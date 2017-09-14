package org.irblleida.bethax

import org.bson.types.ObjectId

class WorkPlanDocument {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    Integer version

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false
        version nullable: false, unique: 'name'
    }
}
