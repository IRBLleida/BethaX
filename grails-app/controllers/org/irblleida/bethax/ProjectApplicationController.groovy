package org.irblleida.bethax

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProjectApplicationController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

        if (projectApplication.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond projectApplication.errors, view:'create'
            return
        }

        projectApplication.save flush:true

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

        if (projectApplication.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond projectApplication.errors, view:'edit'
            return
        }

        projectApplication.save flush:true

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
