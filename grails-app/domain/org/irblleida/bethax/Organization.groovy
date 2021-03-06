package org.irblleida.bethax

import org.bson.types.ObjectId

class Organization {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name

    static constraints = {
        name nullable: false, blank: false, unique: true
    }
}
