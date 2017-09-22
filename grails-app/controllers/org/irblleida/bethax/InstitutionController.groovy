package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class InstitutionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Institution.list(params), model:[institutionCount: Institution.count()]
    }

    def show(Institution institution) {
        respond institution
    }

    def create() {
        respond new Institution(params)
    }

    @Transactional
    def save(Institution institution) {
        if (institution == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (institution.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institution.errors, view:'create'
            return
        }

        institution.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'institution.label', default: 'Institution'), institution.id])
                redirect institution
            }
            '*' { respond institution, [status: CREATED] }
        }
    }

    def edit(Institution institution) {
        respond institution
    }

    @Transactional
    def update(Institution institution) {
        if (institution == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (institution.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institution.errors, view:'edit'
            return
        }

        institution.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'institution.label', default: 'Institution'), institution.id])
                redirect institution
            }
            '*'{ respond institution, [status: OK] }
        }
    }

    @Transactional
    def delete(Institution institution) {

        if (institution == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        institution.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'institution.label', default: 'Institution'), institution.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'institution.label', default: 'Institution'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
