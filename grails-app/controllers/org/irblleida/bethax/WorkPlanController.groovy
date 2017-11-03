package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class WorkPlanController {

    static allowedMethods = [save: "POST", update: "PUT"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WorkPlan.list(params), model:[workPlanCount: WorkPlan.count()]
    }

    def show(WorkPlan workPlan) {
        def workPlanFile = new File("/opt/bethax/workPlan/${workPlan.id.toString()}" as String)
        respond workPlan, model: [workPlanFile: workPlanFile]
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

        workPlan.filename = params.workPlanFile.getOriginalFilename()

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


        def folderPath = "/opt/bethax/workPlan/" as String
        def folder = new File(folderPath)
        if(!folder.exists()) {
            folder.mkdirs()
        }
        def path = "${folderPath}/${workPlan.id}" as String
        def extension = params.workPlanFile.getOriginalFilename().split('\\.').last()
        params.workPlanFile.transferTo(new File(path + "." + extension))
        workPlan.filename = "${workPlan.id}.${extension}"
        println workPlan.filename
        workPlan.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'workPlan.label', default: 'WorkPlan'), workPlan.id])
                redirect workPlan
            }
            '*' { respond workPlan, [status: CREATED] }
        }
    }

    def download(WorkPlan workPlan) {
        if(!workPlan) return

        println workPlan.filename

        def workPlanFile = new File("/opt/bethax/workPlan/${workPlan.filename}" as String)
        if ( workPlanFile.exists() ) {
            response.setContentType("application/octet-stream")
            response.setHeader("Content-disposition", "attachment;filename=\"${workPlan.filename}\"")
            response.outputStream << workPlanFile.bytes
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

        ProjectApplication projectApplication = workPlan.projectApplication
        projectApplication.workPlan = null
        projectApplication.save flush: true

        workPlan.delete flush:true

        flash.message = message(code: 'default.deleted.message', args: [message(code: 'workPlan.label'), workPlan.id])
        redirect controller: "projectApplication", action:"show", id: projectApplication.id, method:"GET"
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
