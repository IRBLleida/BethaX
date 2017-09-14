package org.irblleida.bethax

import org.bson.types.ObjectId

class Milestone {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    Date deadline
    Date dateFinished

    static belongsTo = [workPlan: WorkPlan]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false
        deadline nullable: false
        dateFinished nullable: true
    }
}
