package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class PersonController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Person.list(params), model:[personCount: Person.count()]
    }

    def show(Person person) {
        respond person
    }

    def create() {
        respond new Person(params)
    }

    @Transactional
    def save(Person person) {
        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        person.createdBy = (User) getAuthenticatedUser()
        person.lastModifiedBy = (User) getAuthenticatedUser()

        Person.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) person.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) person.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) person.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        person.validate()

        if (person.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond person.errors, view:'create'
            return
        }

        person.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "persona",
                objectId: person.id.toString(),
                objectName: person.name
        ).save flush: true

        if(params.photo) {
            def folderPath = "/opt/bethax/person/" as String
            def folder = new File(folderPath)
            if(!folder.exists()) folder.mkdirs()
            def path = "${folderPath}/${person.id}" as String
            params.photo.transferTo(new File(path))
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'person.label', default: 'Person'), person.id])
                redirect person
            }
            '*' { respond person, [status: CREATED] }
        }
    }

    def photo(Person person) {
        File img = new File("/opt/bethax/person/" + person?.id?.toString())
        if(!img.exists()) img = new File("/opt/bethax/person/no_photo")
        render file: img.newInputStream(), contentType: 'image/png'
        return
    }

    def edit(Person person) {
        respond person
    }

    @Transactional
    def update(Person person) {
        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        person.lastModifiedBy = (User) getAuthenticatedUser()

        Person.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) person.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) person.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) person.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        person.validate()

        if (person.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond person.errors, view:'edit'
            return
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "editat",
                domainObject: "persona",
                objectId: person.id.toString(),
                objectName: person.name
        ).save flush: true

        person.save flush:true

        if(params.photo) {
            def folderPath = "/opt/bethax/person/" as String
            def path = "${folderPath}/${person.id}" as String
            def currentPhoto = new File(path)
            if(currentPhoto.exists()) currentPhoto.delete()
            params.photo.transferTo(new File(path))
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'person.label', default: 'Person'), person.id])
                redirect person
            }
            '*'{ respond person, [status: OK] }
        }
    }

    @Transactional
    def delete(Person person) {
        if (person == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "persona",
                objectId: person.id.toString(),
                objectName: person.name
        ).save flush: true

        def projects = Project.findAllByPrincipalInvestigator(person)
        def requests = ProjectApplication.findAllByApplicant(person)

        if(projects || requests) {
            flash.message = message(code: 'person.not.deleted')
            println projects
            render view: 'show', model: [person: person, projects: projects, requests: requests]
            return
        }

        person.delete flush:true

        redirect action: 'index'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
