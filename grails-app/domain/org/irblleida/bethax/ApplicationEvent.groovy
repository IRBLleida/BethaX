package org.irblleida.bethax

import org.bson.types.ObjectId

class ApplicationEvent {
    ObjectId id
    Date dateCreated
    Date lastUpdated

    User triggeredBy
    String action
    String domainObject
    String objectName
    String objectId

    static constraints = {
        triggeredBy nullable: false
        action nullable: false, blank: true
        domainObject nullable: false, blank: false
        objectId nullable: false, blank: false
        objectName nullable: false
    }
}
