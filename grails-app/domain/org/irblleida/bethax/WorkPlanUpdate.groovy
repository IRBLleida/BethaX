package org.irblleida.bethax

import org.bson.types.ObjectId

class WorkPlanUpdate {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    WorkPlan workPlan
    Date updateDate
    String reasons
    WorkPlanDocument document

    static belongsTo = [workPlan: WorkPlan]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        workPlan nullable: false
        updateDate nullable: false
        reasons nullable: false, blank: false
        document nullable: true
    }
}
