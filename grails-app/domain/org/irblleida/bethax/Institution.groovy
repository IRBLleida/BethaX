package org.irblleida.bethax

import org.bson.types.ObjectId

class Institution {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    InstitutionType institutionType

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false, unique: true
        institutionType nullable: false
    }

    String toString() {
        name
    }
}
