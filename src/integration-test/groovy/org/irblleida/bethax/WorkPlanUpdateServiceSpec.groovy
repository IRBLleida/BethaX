package org.irblleida.bethax

import grails.test.mixin.integration.Integration
import grails.gorm.transactions.Rollback
import spock.lang.Specification
import org.hibernate.SessionFactory

@Integration
@Rollback
class WorkPlanUpdateServiceSpec extends Specification {

    WorkPlanUpdateService workPlanUpdateService
    SessionFactory sessionFactory

    private Long setupData() {
        // TODO: Populate valid domain instances and return a valid ID
        //new WorkPlanUpdate(...).save(flush: true, failOnError: true)
        //new WorkPlanUpdate(...).save(flush: true, failOnError: true)
        //WorkPlanUpdate workPlanUpdate = new WorkPlanUpdate(...).save(flush: true, failOnError: true)
        //new WorkPlanUpdate(...).save(flush: true, failOnError: true)
        //new WorkPlanUpdate(...).save(flush: true, failOnError: true)
        assert false, "TODO: Provide a setupData() implementation for this generated test suite"
        //workPlanUpdate.id
    }

    void "test get"() {
        setupData()

        expect:
        workPlanUpdateService.get(1) != null
    }

    void "test list"() {
        setupData()

        when:
        List<WorkPlanUpdate> workPlanUpdateList = workPlanUpdateService.list(max: 2, offset: 2)

        then:
        workPlanUpdateList.size() == 2
        assert false, "TODO: Verify the correct instances are returned"
    }

    void "test count"() {
        setupData()

        expect:
        workPlanUpdateService.count() == 5
    }

    void "test delete"() {
        Long workPlanUpdateId = setupData()

        expect:
        workPlanUpdateService.count() == 5

        when:
        workPlanUpdateService.delete(workPlanUpdateId)
        sessionFactory.currentSession.flush()

        then:
        workPlanUpdateService.count() == 4
    }

    void "test save"() {
        when:
        assert false, "TODO: Provide a valid instance to save"
        WorkPlanUpdate workPlanUpdate = new WorkPlanUpdate()
        workPlanUpdateService.save(workPlanUpdate)

        then:
        workPlanUpdate.id != null
    }
}
