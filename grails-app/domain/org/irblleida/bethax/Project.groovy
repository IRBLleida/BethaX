package org.irblleida.bethax

import org.bson.types.ObjectId

class Project {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    Date entryDate
    String name
    String description
    InstitutionType applicationType
    Institution institution
    String applicantName
    String applicantPhone
    String applicantEmail
    Boolean isFromResearchProject
    String rProjectHeadInvestigator
    String rProjectName
    ResearchProjectType rProjectType
    /** CREC: Clinical Research Ethics Committee */
    Boolean isCREC
    StudyType studyType
    String studyTypeOthers

    Boolean isCompetitiveProject
    Boolean isStudyDesign
    Boolean isPaperWriting
    Boolean isDatabaseDesign
    Boolean isDataAnalysis
    String otherInquiry

    String comments
    User headStatistician
    User supportStatistician


    static constraints = {
    }
}
