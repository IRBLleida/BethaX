package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class ProjectApplicationController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ProjectApplication.list(params), model:[projectApplicationCount: ProjectApplication.count()]
    }

    def ajaxList() {
        // TODO: optimize search
        render ProjectApplication.findAll().findAll{ it.state == ProjectApplicationState.WAITING } as JSON
        return
    }

    def ajaxApplicant(){

    }

    def show(ProjectApplication projectApplication) {
        respond projectApplication
    }

    def create() {
        respond new ProjectApplication(params)
    }

    @Transactional
    def save(ProjectApplication projectApplication) {
        if (projectApplication == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        projectApplication.createdBy = (User) getAuthenticatedUser()
        projectApplication.lastModifiedBy = (User) getAuthenticatedUser()

        ProjectApplication.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) projectApplication.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) projectApplication.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) projectApplication.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        projectApplication.validate()

        if (projectApplication.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond projectApplication.errors, view:'create'
            return
        }

        projectApplication.save flush:true
        projectApplication.projects.each { project ->
            project.addToRequests(projectApplication)
            project.save flush: true
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "sol·licitud",
                objectId: projectApplication.id.toString(),
                objectName: projectApplication.name
        ).save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'projectApplication.label', default: 'ProjectApplication'), projectApplication.id])
                redirect projectApplication
            }
            '*' { respond projectApplication, [status: CREATED] }
        }
    }

    def edit(ProjectApplication projectApplication) {
        respond projectApplication
    }

    @Transactional
    def update(ProjectApplication projectApplication) {
        if (projectApplication == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        projectApplication.lastModifiedBy = (User) getAuthenticatedUser()

        ProjectApplication.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) projectApplication.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) projectApplication.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) projectApplication.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        projectApplication.validate()

        if (projectApplication.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond projectApplication.errors, view:'edit'
            return
        }

        def isFinished = false
        if(projectApplication.isDirty('closingDate')){
            def currentProjectApplicationDate = projectApplication.getPersistentValue('closingDate')
            if(currentProjectApplicationDate == null && projectApplication.closingDate != null){
                new ApplicationEvent(
                        triggeredBy: (User) getAuthenticatedUser(),
                        action: "finalitzat",
                        domainObject: "sol·licitud",
                        objectId: projectApplication.id.toString(),
                        objectName: projectApplication.name
                ).save flush: true
                isFinished = true
            }
        }

        projectApplication.save flush:true

        if(!isFinished){
            new ApplicationEvent(
                    triggeredBy: (User) getAuthenticatedUser(),
                    action: "editat",
                    domainObject: "sol·licitud",
                    objectId: projectApplication.id.toString(),
                    objectName: projectApplication.name
            ).save flush: true
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'projectApplication.label', default: 'ProjectApplication'), projectApplication.id])
                redirect projectApplication
            }
            '*'{ respond projectApplication, [status: OK] }
        }
    }

    @Transactional
    def delete(ProjectApplication projectApplication) {

        if (projectApplication == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "sol·licitud",
                objectId: projectApplication.id.toString(),
                objectName: projectApplication.name
        ).save flush: true
        
        projectApplication.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'projectApplication.label', default: 'ProjectApplication'), projectApplication.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'projectApplication.label', default: 'ProjectApplication'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
