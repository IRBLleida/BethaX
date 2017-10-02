package org.irblleida.bethax

import org.bson.types.ObjectId

class Person {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    String phone
    String email
    Institution institution
    InstitutionSection section

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false, unique: true
        phone nullable: true, blank: true
        email nullable: false, blank: false, unique: true
        institution nullable: false
        section nullable: true
    }
}
