package org.irblleida.bethax

import groovy.time.TimeCategory
import org.bson.types.ObjectId

class Milestone {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    String description
    Date deadline
    Date dateFinished

    /** Days to Expiration */
    Integer getDte() {
        use(TimeCategory) {
            return (this.deadline.clearTime() - new Date().clearTime()).days
        }
    }

    static belongsTo = [workPlan: WorkPlan]

    static transients = ['dte']

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false, maxSize: 30
        description nullable: true, blank: true, maxSize: 500
        deadline nullable: false
        dateFinished nullable: true
    }

    String toString() { name }
}
