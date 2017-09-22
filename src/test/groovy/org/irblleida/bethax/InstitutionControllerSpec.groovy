package org.irblleida.bethax

import grails.test.mixin.*
import spock.lang.*

@TestFor(InstitutionController)
@Mock(Institution)
class InstitutionControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.institutionList
            model.institutionCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.institution!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def institution = new Institution()
            institution.validate()
            controller.save(institution)

        then:"The create view is rendered again with the correct model"
            model.institution!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            institution = new Institution(params)

            controller.save(institution)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/institution/show/1'
            controller.flash.message != null
            Institution.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def institution = new Institution(params)
            controller.show(institution)

        then:"A model is populated containing the domain instance"
            model.institution == institution
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def institution = new Institution(params)
            controller.edit(institution)

        then:"A model is populated containing the domain instance"
            model.institution == institution
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/institution/index'
            flash.message != null

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def institution = new Institution()
            institution.validate()
            controller.update(institution)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.institution == institution

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            institution = new Institution(params).save(flush: true)
            controller.update(institution)

        then:"A redirect is issued to the show action"
            institution != null
            response.redirectedUrl == "/institution/show/$institution.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/institution/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def institution = new Institution(params).save(flush: true)

        then:"It exists"
            Institution.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(institution)

        then:"The instance is deleted"
            Institution.count() == 0
            response.redirectedUrl == '/institution/index'
            flash.message != null
    }
}
