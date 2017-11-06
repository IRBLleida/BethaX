package org.irblleida.bethax

import org.bson.types.ObjectId

/** Research group, service or department */
class InstitutionSection {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    Institution institution
    String name

    static belongsTo = [institution: Institution]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        institution nullable: false
        name nullable: false, blank: false, unique: 'institution'
    }

    String toString() {
        name
    }
}
