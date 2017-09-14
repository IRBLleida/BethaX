package org.irblleida.bethax

import org.bson.types.ObjectId

class FundingBody {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false, unique: true
    }
}
