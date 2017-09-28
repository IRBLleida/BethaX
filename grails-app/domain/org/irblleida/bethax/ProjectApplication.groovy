package org.irblleida.bethax

import org.bson.types.ObjectId

class ProjectApplication {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    Date entryDate
    String name
    String description
    ProjectApplication linkedApplication
    InstitutionType applicationType
    Person applicant
    User headStatistician
    Float budget
    Boolean isWorkPlanNeeded
    NoWorkPlanReason noWorkPlanReason
    WorkPlan workPlan

    Date closingDate
    String closingComments
    Boolean isInvoiceIssued
    Float invoiceAmount
    Date invoiceDate
    Date invoicePaymentDate

    ProjectApplicationState getState() {
        Date today = new Date()
        if(closingDate != null){
            if (today.before(closingDate) && today.after(entryDate))  return ProjectApplicationState.ACTIVE
            else if (today.after(closingDate))  return ProjectApplicationState.FINISHED
        }else {
            if (today.before(entryDate)) return ProjectApplicationState.WAITING
            else return ProjectApplicationState.ACTIVE
        }
    }

    static transients = ['state']

    static hasMany = [
            projects: Project,
            typeOfQueries: TypeOfQuery,
            events: ApplicationEvent
    ]

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        entryDate nullable: false
        name nullable: false, blank: false
        description nullable: true, blank: true
        linkedApplication nullable: true
        applicationType nullable: false
        applicant nullable: false
        budget nullable: false, min: new Float(0.0)
        isWorkPlanNeeded nullable: true
        noWorkPlanReason nullable: true
        workPlan nullable: true
        closingDate nullable: true
        closingComments nullable: true
        isInvoiceIssued nullable: true
        invoiceAmount nullable: true
        invoiceDate nullable: true
        invoicePaymentDate nullable: true
    }
}
