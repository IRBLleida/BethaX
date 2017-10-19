package org.irblleida.bethax

import org.bson.types.ObjectId

class ServiceRequest {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User lastModifiedBy

    String name
    String department
    String institution
    String phone
    String email
    String researchProject
    String principalResearcher
    /** CREC: Clinical Research Ethics Committee */
    Boolean isCREC
    StudyType studyType
    String otherStudyType
    String studyObjective
    Boolean isCompetitiveProject
    Boolean isStudyDesign
    Boolean isPaperWriting
    Boolean isDatabaseDesign
    Boolean isDataAnalysis
    Boolean isOthers
    String others
    String comments

    Boolean isApproved
    User approvedBy
    ProjectApplication projectApplication

    static constraints = {
        lastModifiedBy nullable: true
        name nullable: false, blank: false
        department nullable: true, blank: true
        institution nullable: false
        phone nullable: true
        email nullable: true
        researchProject nullable: true
        principalResearcher nullable: true
        isCREC nullable: true
        studyType nullable: true
        otherStudyType nullable: true
        studyObjective nullable: true
        isCompetitiveProject nullable: true
        isStudyDesign nullable: true
        isPaperWriting nullable: true
        isDatabaseDesign nullable: true
        isDataAnalysis nullable: true
        isOthers nullable: true
        others nullable: true
        comments nullable: true

        isApproved nullable: true
        approvedBy nullable: true
        projectApplication nullable: true
    }
}
