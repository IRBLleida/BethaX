package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class InstitutionController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

        institution.createdBy = (User) getAuthenticatedUser()
        institution.lastModifiedBy = (User) getAuthenticatedUser()

        Institution.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) institution.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) institution.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) institution.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        institution.validate()

        if (institution.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institution.errors, view:'create'
            return
        }

        institution.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "institució",
                objectId: institution.id.toString(),
                objectName: institution.name
        ).save flush: true
        
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

        institution.lastModifiedBy = (User) getAuthenticatedUser()

        Institution.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) institution.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) institution.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) institution.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        institution.validate()

        if (institution.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institution.errors, view:'edit'
            return
        }

        institution.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "editat",
                domainObject: "institució",
                objectId: institution.id.toString(),
                objectName: institution.name
        ).save flush: true

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

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "institució",
                objectId: institution.id.toString(),
                objectName: institution.name
        ).save flush: true

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
