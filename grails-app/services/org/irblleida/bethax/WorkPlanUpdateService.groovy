package org.irblleida.bethax

import grails.gorm.services.Service

@Service(WorkPlanUpdate)
interface WorkPlanUpdateService {

    WorkPlanUpdate get(Serializable id)

    List<WorkPlanUpdate> list(Map args)

    Long count()

    void delete(Serializable id)

    WorkPlanUpdate save(WorkPlanUpdate workPlanUpdate)

}