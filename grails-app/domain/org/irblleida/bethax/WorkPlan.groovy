package org.irblleida.bethax

import org.bson.types.ObjectId

class WorkPlan {
    ObjectId id
    Date dateCreated
    Date lastUpdated
    User createdBy
    User lastModifiedBy

    ProjectApplication projectApplication
    Date dateDone
    Date dateAccepted
    Float wpVersion
    String filename

    String getProjectApplicationName() {
        this.projectApplication.name
    }

    Milestone getClosestMilestone(){
        Milestone closestMilestone = null
        this.milestones.each { milestone ->
            if(milestone.dte >= 0){
                if(!closestMilestone) closestMilestone = milestone
                if(closestMilestone.dte > milestone.dte) closestMilestone = milestone
            }
        }
        return closestMilestone
    }

    Integer getMilestonesEstimatedTime(){
        Integer time = 0
        this.milestones.each { milestone ->
            if(!milestone.dateFinished){
                time += milestone.estimatedTime
            }
        }
        return time
    }

    static belongsTo = [projectApplication: ProjectApplication]

    static hasMany = [
            updates: WorkPlanUpdate,
            milestones: Milestone
    ]

    static transients = ['projectApplicationName', 'closestMilestone', 'milestonesEstimatedTime']

    static constraints = {
        createdBy nullable: false
        lastModifiedBy nullable: false
        projectApplication nullable: false
        dateDone nullable: false
        dateAccepted nullable: true
        wpVersion nullable: false
        filename nullable: false
    }

    static mapping = {
        milestones sort: 'deadline', order: 'desc'
    }

    String toString() {
        "v" + wpVersion + " [" + projectApplication.name + "]"
    }
}
