package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ProjectController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ProjectApplication.list(params), model:[projectCount: ProjectApplication.count()]
    }

    def show(ProjectApplication project) {
        respond project
    }

    def create() {
        respond new ProjectApplication(params)
    }

    @Transactional
    def save(ProjectApplication project) {
        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (project.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond project.errors, view:'create'
            return
        }

        project.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'ProjectApplication'), project.id])
                redirect project
            }
            '*' { respond project, [status: CREATED] }
        }
    }

    def edit(ProjectApplication project) {
        respond project
    }

    @Transactional
    def update(ProjectApplication project) {
        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (project.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond project.errors, view:'edit'
            return
        }

        project.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'ProjectApplication'), project.id])
                redirect project
            }
            '*'{ respond project, [status: OK] }
        }
    }

    @Transactional
    def delete(ProjectApplication project) {

        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        project.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'ProjectApplication'), project.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'ProjectApplication'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
