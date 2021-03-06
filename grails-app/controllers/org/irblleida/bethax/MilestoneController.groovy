package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class MilestoneController {

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        if(!params['sort']) params['sort'] = 'deadline'
        if(!params['order']) params['order'] = 'asc'
        def myOpenMilestones = Milestone.findAllByHeadStatisticianAndDateFinishedIsNull((User) getAuthenticatedUser(), params)
        println(myOpenMilestones)
        params.max = 10
        params['sort'] = 'dateFinished'
        def myClosedMilestones =  Milestone.findAllByHeadStatisticianAndDateFinishedIsNotNull((User) getAuthenticatedUser(), params)

        render view: 'index', model:[myOpenMilestones: myOpenMilestones,
                                     myClosedMilestones: myClosedMilestones,
                                     openedMilestonesCount: myOpenMilestones.size()]
    }

    def closed(){
        if(!params['sort']) params['sort'] = 'dateFinished'
        if(!params['order']) params['order'] = 'desc'
        def myClosedMilestones =  Milestone.findAllByHeadStatisticianAndDateFinishedIsNotNull((User) getAuthenticatedUser(), params)

        render view: 'closed', model:[myClosedMilestones: myClosedMilestones,
                                     milestonesCount: myClosedMilestones.size()]
    }

    def ajaxList() {
        def result = []
        def user = (User) getAuthenticatedUser()

        Milestone.list().each { milestone ->
            def color = "#65a9d7"
            if(milestone.headStatistician == user) color = '#6AA84F'

            result.add(['title': "[" + milestone.headStatistician + "] " + milestone.name, 'start': milestone.deadline, 'allDay': 1, 'url': createLink(controller: 'workPlan', action: 'show', id: milestone.workPlan.id.toString()), color: color])
        }
        render result as JSON
    }

    def show(Milestone milestone) {
        respond milestone
    }

    def create() {
        respond new Milestone(params)
    }

    @Transactional
    def save(Milestone milestone) {
        if (milestone == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        milestone.createdBy = (User) getAuthenticatedUser()
        milestone.lastModifiedBy = (User) getAuthenticatedUser()

        //TODO: Es necessari?
        if(!milestone.headStatistician)
            milestone.headStatistician = milestone.workPlan.projectApplication.headStatistician

        Milestone.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) milestone.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) milestone.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) milestone.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        milestone.validate()

        if (milestone.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond milestone.errors, view:'create'
            return
        }

        def workPlan = milestone?.workPlan
        workPlan.addToMilestones(milestone)
        workPlan.save flush: true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "fita",
                objectId: milestone.id.toString(),
                objectName: milestone.name
        ).save flush: true

        flash.message = message(code: 'default.created.message', args: [message(code: 'milestone.label'), milestone.id])
        redirect controller: "workPlan", action: "show", id: workPlan.id
    }

    def edit(Milestone milestone) {
        respond milestone
    }

    @Transactional
    def update(Milestone milestone) {
        if (milestone == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        milestone.lastModifiedBy = (User) getAuthenticatedUser()

        Milestone.getDeclaredFields().each {
            if(it.type == Date && params[it.name]) milestone.properties[it.name] = Date.parse("dd/MM/yyyy", params[it.name])
            if(it.type == Float && params[it.name]) milestone.properties[it.name] = Float.parseFloat(params[it.name].replace(',', '.'))
            if(it.type == Double && params[it.name]) milestone.properties[it.name] = Double.parseDouble(params[it.name].replace(',', '.'))
        }

        milestone.validate()
        def isFinished = false

        if(milestone.isDirty('dateFinished')){
            def currentMilestoneDate = milestone.getPersistentValue('dateFinished')
            if(currentMilestoneDate == null && milestone.dateFinished != null){
                new ApplicationEvent(
                        triggeredBy: (User) getAuthenticatedUser(),
                        action: "finalitzat",
                        domainObject: "fita",
                        objectId: milestone.id.toString(),
                        objectName: milestone.name
                ).save flush: true
                isFinished = true
            }
        }

        milestone.save flush:true

        if (milestone.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond milestone.errors, view:'edit'
            return
        }

        if(!isFinished){
            new ApplicationEvent(
                    triggeredBy: (User) getAuthenticatedUser(),
                    action: "editat",
                    domainObject: "fita",
                    objectId: milestone.id.toString(),
                    objectName: milestone.name
            ).save flush: true
        }

        redirect controller: "workPlan", action: "show", id: milestone.workPlan.id
    }

    @Transactional
    def delete(Milestone milestone) {

        if (milestone == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "fita",
                objectId: milestone.id.toString(),
                objectName: milestone.name
        ).save flush: true

        def workPlan = milestone.workPlan
        workPlan.removeFromMilestones(milestone)
        milestone.delete flush:true
        workPlan.save flush: true

        redirect controller: "workPlan", action: "show", id: workPlan.id
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'milestone.label', default: 'Milestone'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
