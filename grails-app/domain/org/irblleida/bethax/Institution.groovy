package org.irblleida.bethax

import org.bson.types.ObjectId

class Institution {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    InstitutionType institutionType
    String name

    static constraints = {
        institutionType nullable: false
        name nullable: false, blank: false, unique: true
    }
}
