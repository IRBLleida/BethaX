package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class WorkPlanController {

    //static allowedMethods = [save: "POST", update: "PUT"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond WorkPlan.list(params), model:[workPlanCount: WorkPlan.count()]
    }

    def show(WorkPlan workPlan) {
        def workPlanFile = new File("/opt/bethax/workPlan/${workPlan.id.toString()}" as String)

        def openMilestones = Milestone.findAllByWorkPlanAndDateFinishedIsNull(workPlan)
        def closedMilestones = Milestone.findAllByWorkPlanAndDateFinishedIsNotNull(workPlan)

        respond workPlan, model: [workPlanFile: workPlanFile, openMilestones: openMilestones, closedMilestones: closedMilestones]
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

        if(params.workPlanFile) {
            workPlan.filename = params.workPlanFile?.getOriginalFilename()
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

        if(params.workPlanFile) {
            def folderPath = "/opt/bethax/workPlan/" as String
            def folder = new File(folderPath)
            if(!folder.exists()) {
                folder.mkdirs()
            }
            def path = "${folderPath}/${workPlan.id}" as String
            params.workPlanFile.transferTo(new File(path))
        }

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

        def workPlanFile = new File("/opt/bethax/workPlan/${workPlan.id}" as String)
        if(workPlanFile.exists()) {
            if(workPlan.filename.split('\\.').last().equals('pdf')) {
                response.setContentType("application/pdf")
            }
            else response.setContentType("application/octet-stream")

            response.setHeader("Content-disposition", "inline;filename=\"${workPlan.filename}\"")
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

        if(params.workPlanFile) {
            workPlan.filename = params.workPlanFile?.getOriginalFilename()
        }

        workPlan.validate()

        if (workPlan.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond workPlan.errors, view:'edit'
            return
        }

        workPlan.save flush:true

        if(params.workPlanFile) {
            def folderPath = "/opt/bethax/workPlan/" as String
            def path = "${folderPath}/${workPlan.id}" as String
            def currentWorkPlan = new File(path)
            if(currentWorkPlan.exists()) currentWorkPlan.delete()
            params.workPlanFile.transferTo(new File(path))
        }

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

        if(workPlan.filename) {
            def folderPath = "/opt/bethax/workPlan/" as String
            def path = "${folderPath}/${workPlan.id}" as String
            def currentWorkPlan = new File(path)
            if(currentWorkPlan.exists()) currentWorkPlan.delete()
        }

        workPlan.updates.each { update ->
            if(update.filename) {
                def folderPath = "/opt/bethax/workPlanUpdate/" as String
                def path = "${folderPath}/${workPlan.id}" as String
                def currentWorkPlanUpdate = new File(path)
                if(currentWorkPlanUpdate.exists()) currentWorkPlanUpdate.delete()
            }
        }

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
