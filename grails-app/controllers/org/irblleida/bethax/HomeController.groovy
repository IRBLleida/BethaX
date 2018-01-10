package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import groovy.time.TimeCategory
import org.springframework.web.servlet.LocaleResolver
import org.springframework.web.servlet.support.RequestContextUtils

import java.text.DateFormatSymbols

class HomeController {
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def index() {
        if (!session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE') {
            LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
            localeResolver.setLocale(request, response, new Locale(principal.lang));
        }

        redirect controller: "project", action: "index"
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
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
            if(p.applicationType.value() == 3) externalPriv += 1
        }

        /*** Opened-Milestones divided by users Chart ***/
        def usersMap = [:]
        def usersEstimatedCost = [:]
        def openedMilestones = Milestone.findAllByDateFinishedIsNull()

        for (u in User.findAll()){
            usersMap[u.givenName + ' ' + u.familyName] = 0
            usersEstimatedCost[u.givenName + ' ' + u.familyName] = 0
        }

        for (m in openedMilestones){
            if((m.deadline.getTime() - today.getTime()) >= 0){
                usersMap[m.headStatistician.givenName + ' ' + m.headStatistician.familyName] += 1
                if(m.estimatedTime) usersEstimatedCost[m.headStatistician.givenName + ' ' + m.headStatistician.familyName] += m.estimatedTime
            }
        }

        /*** Institutions ***/
        def institutionList = [:]
        for(institution in Institution.findAll()){
            institutionList[institution] = 0
        }
        for(pA in ProjectApplication.findAll()){
            if(pA.applicant.institution)
                institutionList[pA.applicant.institution] += 1
        }

        render view:'summary', model: [institutionList: institutionList, pendingMilestones: pendingMilestones,
                                       finishedMilestones: finishedMilestones, projectApplications: projectApplicationsSize,
                                       projects: projects, monthString: monthsString.reverse(),
                                       createdMilestones: createdMilestones, closedMilestones: closedMilestones,
                                       internal: internal, externalPub: externalPub, externalPriv: externalPriv,
                                       usersMap: usersMap, usersEstimatedCost: usersEstimatedCost]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def calendar(){
        render view:'calendar', model: []
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def activity(){
        def applicationEventList = ApplicationEvent.findAll(max: 10, sort: "dateCreated", order: "desc")
        def applicationEventListUser = ApplicationEvent.findAllByTriggeredBy((User) getAuthenticatedUser(), [max: 10, sort: "dateCreated", order: "desc"])

        render view:'activity', model: [applicationEventList: applicationEventList, applicationEventListUser: applicationEventListUser]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def search() {
        User user = User.get(((User) getAuthenticatedUser()).id)
        def query = "%" + params?.query + "%"
        //render Patient.findAllByGivenNameIlikeOrFirstSurnameIlikeOrSecondSurnameIlikeOrClinicalHistoryIlike(
        //        query, query, query, query, [max: 10, sort: "lastUpdated", order: "desc"]
        //) as JSON

        def projects = []
        def projectList = Project.findAllByNameIlikeOrDescriptionIlike(query, query, [max: 5, sort: "lastUpdated", order: "desc"])
        projectList.each { project ->
            projects.add([id: project.id.toString(), name: project.name])
        }

        def requests = []
        def projectApplicationList = ProjectApplication.findAllByNameIlikeOrDescriptionIlike(query, query, [max: 5, sort: "lastUpdated", order: "desc"])
        projectApplicationList.each { projectApplication ->
            requests.add([id: projectApplication.id.toString(), name: projectApplication.name, projects: projectApplication.projects*.name ?: ''])
        }


        def milestones = []
        def myProjectApplicationList = ProjectApplication.findAllByHeadStatistician(user , [sort: "deadline", order: "asc"])
        myProjectApplicationList.each { projectApplication ->
            projectApplication?.workPlan?.milestones?.each { milestone ->
                if(!milestone.dateFinished && (milestone.name.contains(params?.query) || milestone.description.contains(params?.query))) {
                    milestones.add([id: milestone.workPlan.id.toString(), name: milestone.name, date: milestone.deadline])
                }
            }
        }

        def institutions = []
        def institutionList = Institution.findAllByNameIlike(query, [max: 5, sort: "dateCreated", order: "desc"])
        institutionList.each { institution ->
            institutions.add([id: institution.id.toString(), name: institution.name])
        }

        def persons = []
        def personList = Person.findAllByNameIlike(query, [max: 5, sort: "dateCreated", order: "desc"])
        personList.each { person ->
            persons.add([id: person.id.toString(), name: person.name, institution: person.institution.name])
        }

        def users = []
        def userList = User.findAllByGivenNameIlikeOrFamilyNameIlike(query, query, [max: 5, sort: "dateCreated", order: "desc"])
        userList.each { usr ->
            users.add([id: usr.id.toString(), name: usr.givenName + ' ' + usr.familyName, username: usr.username])
        }

        def result = [
                projects: projects,
                requests: requests,
                milestones: milestones,
                institutions: institutions,
                persons: persons,
                users: users
        ]

        if(projects.empty && requests.empty && milestones.empty && institutions.empty && persons.empty && users.empty)
            result = []

        render result as JSON
        return
    }

    def acmeChallenge(String id) {
        File file = new File("/opt/bethax/acme-challenge/${id}")
        if(file.exists()) render file.text
        else render ""
        return
    }
}
