package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured
import org.renjin.script.RenjinScriptEngineFactory
import org.renjin.sexp.SEXP

import javax.script.ScriptEngine

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class ProjectController {

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Project.list(params), model:[projectCount: Project.count(), rresponse: params?.rresponse]
    }

    def show(Project project) {
        respond project
    }

    def create() {
        respond new Project(params)
    }

    @Transactional
    def save(Project project) {
        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        project.createdBy = (User) getAuthenticatedUser()
        project.lastModifiedBy = (User) getAuthenticatedUser()

        project.validate()

        if (project.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond project.errors, view:'create'
            return
        }

        project.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "creat",
                domainObject: "projecte",
                objectId: project.id.toString(),
                objectName: project.name
        ).save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), project.id])
                redirect project
            }
            '*' { respond project, [status: CREATED] }
        }
    }

    def edit(Project project) {
        respond project
    }

    @Transactional
    def update(Project project) {
        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        project.lastModifiedBy = (User) getAuthenticatedUser()

        if (project.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond project.errors, view:'edit'
            return
        }

        project.save flush:true

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "editat",
                domainObject: "projecte",
                objectId: project.id.toString(),
                objectName: project.name
        ).save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), project.id])
                redirect project
            }
            '*'{ respond project, [status: OK] }
        }
    }

    @Transactional
    def delete(Project project) {

        if (project == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if(project.requests) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'project.label', default: 'Project'), project.toString()])
            redirect action: 'show', id: project.id
            return
        }

        new ApplicationEvent(
                triggeredBy: (User) getAuthenticatedUser(),
                action: "eliminat",
                domainObject: "projecte",
                objectId: project.id.toString(),
                objectName: project.name
        ).save flush: true

        project.delete flush:true
        flash.message = message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), project.id])
        redirect action: 'index'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }


    def rtest() {
        RenjinScriptEngineFactory factory = new RenjinScriptEngineFactory();
        // create a Renjin engine:
        ScriptEngine engine = factory.getScriptEngine();
        def response = (SEXP)engine.eval(params?.rcode);

        //engine.eval("df <- data.frame(x=1:10, y=(1:10)+rnorm(n=10))");
        //SEXP res1 = (SEXP)engine.eval("print(df)");
        //SEXP res2 = (SEXP)engine.eval("print(lm(y ~ x, df))");

        println response
        redirect action: "index", model: ['rresponse': response]
    }
}
