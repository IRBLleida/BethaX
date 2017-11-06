package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WorkPlanUpdateController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WorkPlanUpdate.list(params), model:[workPlanUpdateCount: WorkPlanUpdate.count()]
    }

    def show(WorkPlanUpdate workPlanUpdate) {
        respond workPlanUpdate
    }

    def create() {
        respond new WorkPlanUpdate(params)
    }

    @Transactional
    def save(WorkPlanUpdate workPlanUpdate) {
        if (workPlanUpdate == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workPlanUpdate.createdBy = (User) getAuthenticatedUser()
        workPlanUpdate.lastModifiedBy = (User) getAuthenticatedUser()

        WorkPlanUpdate.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) workPlanUpdate.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) workPlanUpdate.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) workPlanUpdate.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        if(params.document) {
            workPlanUpdate.filename = params.document?.getOriginalFilename()
        }

        workPlanUpdate.validate()

        if (workPlanUpdate.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workPlanUpdate.errors, view:'create'
            return
        }

        def workPlan = workPlanUpdate.workPlan
        workPlan.addToUpdates(workPlanUpdate)
        workPlan.save flush: true

        if(params.document) {
            def folderPath = "/opt/bethax/workPlanUpdate/" as String
            def folder = new File(folderPath)
            if(!folder.exists()) {
                folder.mkdirs()
            }
            def path = "${folderPath}/${workPlanUpdate.id}" as String
            params.document.transferTo(new File(path))
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'workPlanUpdate.label'), workPlanUpdate.id])
        redirect controller: "workPlan", action: "show", id: workPlan.id
    }

    def download(WorkPlanUpdate workPlanUpdate) {
        if(!workPlanUpdate) return

        def workPlanUpdateFile = new File("/opt/bethax/workPlanUpdate/${workPlanUpdate.id}" as String)
        if(workPlanUpdateFile.exists()) {
            if(workPlanUpdate.filename.split('\\.').last().equals('pdf')) {
                response.setContentType("application/pdf")
            }
            else response.setContentType("application/octet-stream")

            response.setHeader("Content-disposition", "inline;filename=\"${workPlanUpdate.filename}\"")
            response.outputStream << workPlanUpdateFile.bytes
        }
    }

    def edit(WorkPlanUpdate workPlanUpdate) {
        respond workPlanUpdate
    }

    @Transactional
    def update(WorkPlanUpdate workPlanUpdate) {
        if (workPlanUpdate == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        workPlanUpdate.lastModifiedBy = (User) getAuthenticatedUser()

        WorkPlanUpdate.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) workPlanUpdate.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) workPlanUpdate.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) workPlanUpdate.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        if(params.document) {
            workPlanUpdate.filename = params.document?.getOriginalFilename()
        }

        if (workPlanUpdate.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workPlanUpdate.errors, view:'edit'
            return
        }

        workPlanUpdate.save flush:true

        if(params.document) {
            def folderPath = "/opt/bethax/workPlanUpdate/" as String
            def folder = new File(folderPath)
            if(!folder.exists()) {
                folder.mkdirs()
            }
            def path = "${folderPath}/${workPlanUpdate.id}" as String

            def currentWorkPlanUpdate = new File(path)
            if(currentWorkPlanUpdate.exists()) currentWorkPlanUpdate.delete()
            params.document.transferTo(new File(path))
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'workPlanUpdate.label', default: 'WorkPlanUpdate'), workPlanUpdate.id])
                redirect workPlanUpdate
            }
            '*'{ respond workPlanUpdate, [status: OK] }
        }
    }

    @Transactional
    def delete(WorkPlanUpdate workPlanUpdate) {

        if (workPlanUpdate == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if(workPlanUpdate.filename) {
            def folderPath = "/opt/bethax/workPlanUpdate/" as String
            def path = "${folderPath}/${workPlanUpdate.id}" as String
            def currentWorkPlanUpdate = new File(path)
            if(currentWorkPlanUpdate.exists()) currentWorkPlanUpdate.delete()
        }

        def workPlan = workPlanUpdate.workPlan
        workPlan.removeFromUpdates(workPlanUpdate)
        workPlanUpdate.delete flush:true
        workPlan.save flush: true

        redirect controller: "workPlan", action: "show", id: workPlan.id
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'workPlanUpdate.label', default: 'WorkPlanUpdate'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
