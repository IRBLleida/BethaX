package org.irblleida.bethax

import grails.test.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class InstitutionSectionServiceSpec extends Specification {

    InstitutionSectionService institutionSectionService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new InstitutionSection(...).save(flush: true, failOnError: true)
        //new InstitutionSection(...).save(flush: true, failOnError: true)
        //InstitutionSection institutionSection = new InstitutionSection(...).save(flush: true, failOnError: true)
        //new InstitutionSection(...).save(flush: true, failOnError: true)
        //new InstitutionSection(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //institutionSection.id
    }

    void "test get"() {
        setupData()

        expect:
        institutionSectionService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<InstitutionSection> institutionSectionList = institutionSectionService.list(max: 2, offset: 2)

        then:
        institutionSectionList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        institutionSectionService.count() == 5
    }

    void "test delete"() {
        Long institutionSectionId = setupData()

        expect:
        institutionSectionService.count() == 5

        when:
        institutionSectionService.delete(institutionSectionId)
        sessionFactory.currentSession.flush()

        then:
        institutionSectionService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        InstitutionSection institutionSection = new InstitutionSection()
        institutionSectionService.save(institutionSection)

        then:
        institutionSection.id != null
    }
}
