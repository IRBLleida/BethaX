package org.irblleida.bethax

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ServiceRequestController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond ServiceRequest.list(params), model:[serviceRequestCount: ServiceRequest.count()]
    }

    def show(ServiceRequest serviceRequest) {
        respond serviceRequest
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
            transactionStatus.setRollbackOnly()
            respond serviceRequest.errors, view:'create'
            return
        }

        serviceRequest.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'serviceRequest.label', default: 'ServiceRequest'), serviceRequest.id])
                redirect serviceRequest
            }
            '*' { respond serviceRequest, [status: CREATED] }
        }
    }

    def edit(ServiceRequest serviceRequest) {
        respond serviceRequest
    }

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
