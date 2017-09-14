package org.irblleida.bethax

import org.bson.types.ObjectId

class WorkPlan {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    ProjectApplication application
    Date dateDone
    Date dateAccepted
    Float wpVersion
    Float budget

    static belongsTo = [application: ProjectApplication]

    static hasMany = [
            documents: WorkPlanDocument,
            updates: WorkPlanUpdate,
            milestones: Milestone
    ]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        application nullable: false
        dateDone nullable: false
        dateAccepted nullable: true
        wpVersion nullable: false
        budget nullable: true, min: 0
    }
}
