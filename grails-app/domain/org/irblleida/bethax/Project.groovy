package org.irblleida.bethax

import org.bson.types.ObjectId

class Project {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    String name
    String description
    Boolean isResearch
    Person principalInvestigator
    Boolean isFunded
    FundingBody fundingBody
    Boolean hasStatisticalFunding
    /** CREC: Clinical Research Ethics Committee */
    Boolean isCREC


    static hasMany = [requests: ProjectApplication]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        name nullable: false, blank: false, unique: true
        description nullable: true, blank: true
        isResearch nullable: false
        principalInvestigator nullable: false
        isFunded nullable: false
        fundingBody nullable: true
        hasStatisticalFunding nullable: true
        isCREC nullable: false
    }

    String toString() {
        name
    }
}
