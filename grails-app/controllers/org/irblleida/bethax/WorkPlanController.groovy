package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WorkPlanController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WorkPlan.list(params), model:[workPlanCount: WorkPlan.count()]
    }

    def show(WorkPlan workPlan) {
        respond workPlan
    }

    def create() {
        respond new WorkPlan(params)
    }

    @Transactional
    def save(WorkPlan workPlan) {
        if (workPlan == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workPlan.createdBy = (User) getAuthenticatedUser()
        workPlan.lastModifiedBy = (User) getAuthenticatedUser()

        WorkPlan.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) workPlan.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) workPlan.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) workPlan.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        workPlan.validate()

        if (workPlan.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workPlan.errors, view:'create'
            return
        }

        workPlan.save flush:true

        def projectApplication = workPlan.projectApplication
        projectApplication.workPlan = workPlan
        projectApplication.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlan.id])
                redirect workPlan
            }
            '*' { respond workPlan, [status: CREATED] }
        }
    }

    def edit(WorkPlan workPlan) {
        respond workPlan
    }

    @Transactional
    def update(WorkPlan workPlan) {
        if (workPlan == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workPlan.lastModifiedBy = (User) getAuthenticatedUser()

        WorkPlan.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) workPlan.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) workPlan.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) workPlan.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        workPlan.validate()

        if (workPlan.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workPlan.errors, view:'edit'
            return
        }

        workPlan.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlan.id])
                redirect workPlan
            }
            '*'{ respond workPlan, [status: OK] }
        }
    }

    @Transactional
    def delete(WorkPlan workPlan) {

        if (workPlan == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workPlan.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlan.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
