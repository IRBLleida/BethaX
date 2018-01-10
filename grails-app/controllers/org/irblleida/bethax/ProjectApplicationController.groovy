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
        def currentUser = (User) getAuthenticatedUser()

        def projectApplicationOthers = ProjectApplication.findAllByHeadStatisticianNotEqual(currentUser, params)
        def projectApplicationOthersCount = ProjectApplication.findAllByHeadStatisticianNotEqual(currentUser).size()
        respond ProjectApplication.findAllByHeadStatistician(currentUser), model:[projectApplicationOthers: projectApplicationOthers, projectApplicationOthersCount: projectApplicationOthersCount]
    }

    def ajaxList() {
        // TODO: optimize search
        render ProjectApplication.findAll().findAll{ it.state == ProjectApplicationState.WAITING } as JSON
        return
    }

    def closeTemplate() {
        def closeTemplate = new File("/opt/bethax/closeTemplate.docx/" as String)
        if(closeTemplate.exists()) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "inline;filename=\"Close_Template.docx\"")
            response.outputStream << closeTemplate.bytes
        }
    }

    def downloadCloseDoc() {
        //TODO
    }

    def show(ProjectApplication projectApplication) {
        respond projectApplication
    }

    def close(ProjectApplication projectApplication) {
        respond projectApplication
    }

    def create() {
        respond new ProjectApplication(params)
    }

    def createFromRequest(ServiceRequest serviceRequest) {
        respond new ProjectApplication(params), model: [serviceRequest: serviceRequest]
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

    @Transactional
    def saveFromRequest(ProjectApplication projectApplication) {
        if(projectApplication == null) {
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

        def serviceRequest = ServiceRequest.get(params.serviceRequest)
        serviceRequest.isApproved = true
        serviceRequest.projectApplication = projectApplication
        serviceRequest.approvedBy = (User) getAuthenticatedUser()
        serviceRequest.save flush: true

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

        def projects = Project.findAll().find{ it.requests && it.requests.contains(projectApplication) }
        projects.each{ project ->
            project.removeFromRequests(projectApplication)
            project.save flush: true
        }
        projectApplication.projects.each { project ->
            project.addToRequests(projectApplication)
            project.save flush: true
        }

        def isFinished = false
        if(projectApplication.isDirty('closingDate')) {
            def currentProjectApplicationDate = projectApplication.getPersistentValue('closingDate')
            if(currentProjectApplicationDate == null && projectApplication.closingDate != null) {
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

        if(params.closeFile?.getOriginalFilename() != null && params.closeFile?.getOriginalFilename() != '') {
            // TODO: Create projectApplication/ directory on server
            def folderPath = "/opt/bethax/projectApplication/" as String
            def path = "${folderPath}/${projectApplication.id}" as String
            def currentCloseFile = new File(path)
            if(currentCloseFile.exists()) currentCloseFile.delete()
            params.closeFile.transferTo(new File(path))
        }

        projectApplication.save flush:true

        if(!isFinished) {
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

        projectApplication.projects.each {project ->
            project.removeFromRequests(projectApplication)
            project.save(flush: true)
        }

        ProjectApplication.findAllByLinkedApplication(projectApplication).each {pA ->
            pA.linkedApplication = null
            pA.save(flush: true)
        }

        projectApplication.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'projectApplication.label', default: 'ProjectApplication'), projectApplication.id])
        redirect action: 'index'
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
