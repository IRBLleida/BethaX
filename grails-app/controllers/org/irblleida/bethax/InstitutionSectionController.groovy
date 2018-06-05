package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class InstitutionSectionController {

    //static allowedMethods = [save: "POST", update: "PUT"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond InstitutionSection.list(params), model:[institutionSectionCount: InstitutionSection.count()]
    }

    def findByInstitution(Institution institution) {
        def data = []
        InstitutionSection.findAllByInstitution(institution).each { data.add([id: it.id.toString(), name: it.name]) }
        render data as JSON
    }

    def show(InstitutionSection institutionSection) {
        def persons = Person.findAllBySection(institutionSection)
        respond institutionSection, model: [projects: Project.findAllByPrincipalInvestigatorInList(persons),
                                            projectApplications: ProjectApplication.findAllByApplicantInList(persons)]
    }

    def create() {
        respond new InstitutionSection(params)
    }

    @Transactional
    def save(InstitutionSection institutionSection) {
        if (institutionSection == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        institutionSection.createdBy = (User) getAuthenticatedUser()
        institutionSection.lastModifiedBy = (User) getAuthenticatedUser()

        InstitutionSection.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) institutionSection.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) institutionSection.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) institutionSection.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        institutionSection.validate()

        if (institutionSection.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institutionSection.errors, view:'create'
            return
        }

        institutionSection.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "secció",
                objectId: institutionSection.id.toString(),
                objectName: institutionSection.name
        ).save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'institutionSection.label', default: 'InstitutionSection'), institutionSection.id])
                redirect controller: 'institution', action: 'show', id: institutionSection.institution.id
            }
            '*' { respond institutionSection, [status: CREATED] }
        }
    }

    def edit(InstitutionSection institutionSection) {
        respond institutionSection
    }

    @Transactional
    def update(InstitutionSection institutionSection) {
        if (institutionSection == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        institutionSection.lastModifiedBy = (User) getAuthenticatedUser()

        InstitutionSection.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) institutionSection.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) institutionSection.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) institutionSection.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        institutionSection.validate()

        if (institutionSection.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond institutionSection.errors, view:'edit'
            return
        }

        institutionSection.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "editat",
                domainObject: "secció",
                objectId: institutionSection.id.toString(),
                objectName: institutionSection.name
        ).save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'institutionSection.label', default: 'InstitutionSection'), institutionSection.id])
                redirect institutionSection
            }
            '*'{ respond institutionSection, [status: OK] }
        }
    }

    @Transactional
    def delete(InstitutionSection institutionSection) {

        if (institutionSection == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        def institution = institutionSection.institution

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "secció",
                objectId: institutionSection.id.toString(),
                objectName: institutionSection.name
        ).save flush: true

        institutionSection.delete flush:true
        redirect controller: 'institution', action: "show", id: institution.id
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'institutionSection.label', default: 'InstitutionSection'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
