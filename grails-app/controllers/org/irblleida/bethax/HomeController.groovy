package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.time.TimeCategory
import org.springframework.web.servlet.LocaleResolver
import org.springframework.web.servlet.support.RequestContextUtils

import java.text.DateFormatSymbols

@Secured(['IS_AUTHENTICATED_FULLY'])
class HomeController {

    def index() {
        if (!session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE') {
            LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
            localeResolver.setLocale(request, response, new Locale(principal.lang));
        }

        redirect controller: "project", action: "index"
    }

    def summary(){
        def today = new Date()
        def tenMonthsAgo = Calendar.getInstance()
        DateFormatSymbols dfs = new DateFormatSymbols()
        String[] months = dfs.getMonths()

        def createdMilestones = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        def closedMilestones = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        def monthsString = [], monthHelper = []
        def i = 0


        use(TimeCategory) {
            for (i = 0; i<10 ;i++){
                tenMonthsAgo.setTime(new Date() - i.months)
                def mo = months[tenMonthsAgo.get(Calendar.MONTH)].replace('de ', '').replace("d’" , "")
                def ye = ( tenMonthsAgo.get(Calendar.YEAR) )
                monthsString.add(mo + " " + ye)
                monthHelper.add(tenMonthsAgo.get(Calendar.MONTH))
            }
        }

        monthHelper = monthHelper.reverse()

        def milestone = Milestone.findAllByDateCreatedGreaterThanEquals(tenMonthsAgo)
        def finishedMilestones = 0, pendingMilestones = 0
        def date = Calendar.getInstance()

        for (m in milestone){
            /*** Finished and Pending Milestones ***/
            if ((m.deadline.getTime() - today.getTime()) > 0 &&  (!m.dateFinished || (m.dateFinished.getTime() - today.getTime()) > 0)){
                pendingMilestones = pendingMilestones + 1
            }else{
                finishedMilestones = finishedMilestones + 1
            }

            /*** Created and Closed Milestones per month ***/
            date.setTime(m.dateCreated)
            createdMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            if(m.dateFinished){
                date.setTime(m.dateFinished)
                closedMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            }
        }

        def projectApplications = ProjectApplication.findAll()
        def projectApplicationsSize = projectApplications.size()
        def projects = Project.findAll().size()

        /*** Counter for ProjectApplication type chart ***/
        def internal = 0, externalPub = 0, externalPriv = 0
        for (p in projectApplications){
            if(p.applicationType.value() == 1) internal += 1
            if(p.applicationType.value() == 2) externalPub += 1
            if(p.applicationType.value() == 2) externalPriv += 1
        }

        /*** Opened-Milestones divided by users Chart ***/
        def usersMap = [:]
        def openedMilestones = Milestone.findAllByDateFinishedIsNull()

        for (u in User.findAll()){
            usersMap[u.givenName + ' ' + u.familyName] = 0
        }

        for (m in openedMilestones){
            if((m.deadline.getTime() - today.getTime()) >= 0){
                usersMap[m.createdBy.givenName + ' ' + m.createdBy.familyName] += 1
            }
        }

        render view:'summary', model: [institutionList: Institution.list(), pendingMilestones: pendingMilestones,
                                       finishedMilestones: finishedMilestones, projectApplications: projectApplicationsSize,
                                       projects: projects, monthString: monthsString.reverse(),
                                       createdMilestones: createdMilestones, closedMilestones: closedMilestones,
                                       internal: internal, externalPub: externalPub, externalPriv: externalPriv,
                                       usersMap: usersMap]
    }

    def calendar(){
        render view:'calendar', model: []
    }

    def activity(){
        render view:'activity', model: []
    }

    def search() {
        User user = User.get(((User) getAuthenticatedUser()).id)
        def query = "%" + params?.query + "%"
        //render Patient.findAllByGivenNameIlikeOrFirstSurnameIlikeOrSecondSurnameIlikeOrClinicalHistoryIlike(
        //        query, query, query, query, [max: 10, sort: "lastUpdated", order: "desc"]
        //) as JSON

        def projects = []
        def projectList = Project.findAllByNameIlikeOrDescriptionIlike(query, query, [sort: "lastUpdated", order: "desc"])
        projectList.each { project ->
            projects.add([id: project.id.toString(), name: project.name])
        }

        def requests = []
        def projectApplicationList = ProjectApplication.findAllByNameIlikeOrDescriptionIlike(query, query, [sort: "lastUpdated", order: "desc"])
        projectApplicationList.each { projectApplication ->
            requests.add([id: projectApplication.id.toString(), name: projectApplication.name, projects: projectApplication.projects*.name ?: ''])
        }

        def result = [
                projects: projects,
                requests: requests
        ]

        render result as JSON
        return
    }
}
