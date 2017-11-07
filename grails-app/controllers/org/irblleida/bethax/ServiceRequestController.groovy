package org.irblleida.bethax

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import javax.xml.ws.Service

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceRequestController {
    def mailService

    //static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def index() {
        render view: 'index', model:[
                pendingServiceRequestList: ServiceRequest.findAllByIsApprovedIsNull(),
                approvedServiceRequestList: ServiceRequest.findAllByIsApproved(true),
                refusedServiceRequestList: ServiceRequest.findAllByIsApproved(false),
        ]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def ajaxList() {
        def serviceRequestList = ServiceRequest.findAllByIsApprovedIsNull()
        def result = []
        serviceRequestList.each { serviceRequest ->
            result.add([id: serviceRequest.id.toString(), name: serviceRequest.name, institution: serviceRequest.institution])
        }
        render result as JSON
        return
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def show(ServiceRequest serviceRequest) {
        respond serviceRequest
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def approve(ServiceRequest serviceRequest) {
        serviceRequest.isApproved = true
        serviceRequest.save flush: true
        redirect action: 'show', id: serviceRequest.id
        return
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def approveAndLink(ServiceRequest serviceRequest) {
        redirect controller: 'projectApplication', action: 'createFromRequest', id: serviceRequest.id
        return
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def reject(ServiceRequest serviceRequest) {
        serviceRequest.isApproved = false
        serviceRequest.save flush: true
        redirect action: 'show', id: serviceRequest.id
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def unrefuse(ServiceRequest serviceRequest) {
        serviceRequest.isApproved = null
        serviceRequest.save flush: true
        redirect action: 'show', id: serviceRequest.id
    }

    def create() {
        respond new ServiceRequest(params)
    }

    @Transactional
    def save(ServiceRequest serviceRequest) {
        if (serviceRequest == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (serviceRequest.hasErrors()) {
            println serviceRequest.errors
            transactionStatus.setRollbackOnly()
            respond serviceRequest.errors, view:'create'
            return
        }

        serviceRequest.save flush:true

        flash.message = message(code: 'default.created.message', args: [message(code: 'serviceRequest.label', default: 'ServiceRequest'), serviceRequest.id])
        redirect action: 'success', id: serviceRequest.id
    }

    def success(ServiceRequest serviceRequest) {
        sendMail {
            to serviceRequest.email
            from "UBiostat <no-reply@bethax.com>"
            subject "Sol·licitud de serveis rebuda correctament"
            html view: "/email/serviceRequestSuccess", model: [serviceRequest: serviceRequest]
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit(ServiceRequest serviceRequest) {
        respond serviceRequest
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    @Transactional
    def update(ServiceRequest serviceRequest) {
        if (serviceRequest == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (serviceRequest.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond serviceRequest.errors, view:'edit'
            return
        }

        serviceRequest.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'serviceRequest.label', default: 'ServiceRequest'), serviceRequest.id])
                redirect serviceRequest
            }
            '*'{ respond serviceRequest, [status: OK] }
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    @Transactional
    def delete(ServiceRequest serviceRequest) {

        if (serviceRequest == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        serviceRequest.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'serviceRequest.label', default: 'ServiceRequest'), serviceRequest.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'serviceRequest.label', default: 'ServiceRequest'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
