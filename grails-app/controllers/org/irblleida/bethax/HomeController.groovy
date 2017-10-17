package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.LocaleResolver
import org.springframework.web.servlet.support.RequestContextUtils

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
        render view:'summary', model: [institutionList: Institution.list()]
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
