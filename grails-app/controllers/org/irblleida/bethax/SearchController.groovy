package org.irblleida.bethax

import java.text.SimpleDateFormat

class SearchController {

    def advanced() { }

    def searchResults(){

        def query = params.text? "%" + params.text + "%": "%%"
        def model = null

        def search = ""
        search += params.text ? ' Que contingui: ' + params.text + "," : ""
        search += params.from ? ' Data minima creació: ' + params.from + "," : ""
        search += params.to ? ' Data màxima creació: ' + params.to + "," : ""
        search += params.closingFrom ? ' Data minima finalització: ' + params.closingFrom + "," : ""
        search += params.closingTo ? ' Data màxima finalització: ' + params.closingTo + "," : ""
        search += params.estimatedGreater ? ' Cost major de: ' + params.estimatedGreater + "," : ""
        search += params.estimatedLower ? ' Cost menor de: ' + params.estimatedLower + "," : ""
        search += params.finished ? ' Solament sol·licituds finalitzades' + "," : ""
        search += params.notPayed ? ' Solament sol·licituds no cobrades' + "," : ""
        search += params.fromRequest ? ' Solament sol·licituds procedents de petició ' + "," : ""
        search += params.notFromRequest ? ' Solament sol·licituds sense petició associada '+ "," : ""

        if(search == "") search = "No s'ha especificat res!"

        //TODO: Afegir el maxim/minim numero de fites a les cerques checkbox
        if(params.fromRequest) model = fromRequest(params)
        if(!model && params.notFromRequest) model = notFromRequest(params, query)
        if(!model) model = checkFinishedAndNotPayed(params, query)
        if(!model) model =  checkOtherInputs(params, query)
        model.put('search', search)

        render view:'searchResults', model: model
    }

    private def fromRequest(params){
        def serviceRequestsList = ServiceRequest.findAllByProjectApplicationIsNotNull()
        def projectApplications = []
        for(s in serviceRequestsList){
            if(s.projectApplication.name.contains(params.text ?: "")){
                if(params.finished && params.notPayed && s.projectApplication.closingDate != null && !s.projectApplication.isInvoiceIssued)
                    projectApplications.add(s.projectApplication)
                else if(params.finished && !params.notPayed && s.projectApplication.closingDate != null)
                    projectApplications.add(s.projectApplication)
                else if(params.notPayed && !params.finished && !s.projectApplication.isInvoiceIssued)
                    projectApplications.add(s.projectApplication)
                else if(!params.notPayed && !params.finished)
                    projectApplications.add(s.projectApplication)
            }
        }
        return [projectApplications: projectApplications]
    }

    private def notFromRequest(params, query){
        def serviceRequestsList = ServiceRequest.findAllByProjectApplicationIsNotNull()
        def projectApplicationsWithServiceRequest = []
        def projectApplications = []
        if(params.finished && params.notPayed)
            projectApplications = ProjectApplication.findAllByClosingDateIsNotNullAndIsInvoiceIssuedAndNameIlike(false, query)
        else if(!params.finished && params.notPayed)
            projectApplications = ProjectApplication.findAllByIsInvoiceIssuedAndNameIlike(false, query)
        else if(params.finished && !params.notPayed)
            projectApplications = ProjectApplication.findAllByClosingDateIsNotNullAndNameIlike(query)
        else if(!params.finished && !params.notPayed)
            projectApplications = ProjectApplication.findAllByNameIlike(query)

        for(s in serviceRequestsList){
            if(s.projectApplication.closingDate != null && !s.projectApplication.isInvoiceIssued && s.projectApplication.name.contains(params.text ?: ""))
                projectApplicationsWithServiceRequest.add(s.projectApplication)
        }

        def response = (projectApplications + projectApplicationsWithServiceRequest) - projectApplications.intersect(projectApplicationsWithServiceRequest)
        return [projectApplications: response]
    }

    private def checkFinishedAndNotPayed(params, query){
        if(params.finished && params.notPayed)
            return [projectApplications: ProjectApplication.findAllByClosingDateIsNotNullAndIsInvoiceIssuedAndNameIlike(false, query)]
        else if(!params.finished && params.notPayed)
            return [projectApplications: ProjectApplication.findAllByIsInvoiceIssuedAndNameIlike(false, query)]
        else if(params.finished && !params.notPayed)
            return [projectApplications: ProjectApplication.findAllByClosingDateIsNotNullAndNameIlike(query)]
        else
            return null
    }

    private def checkOtherInputs(params, query){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        Date minDate = sdf.parse("01/01/1950")
        Date maxDate = new Date()

        if(params.from) minDate = sdf.parse(params.from)
        if(params.to) maxDate = sdf.parse(params.to)

        Calendar c = Calendar.getInstance()
        c.setTime(minDate)
        c.add(Calendar.DATE, 1)
        minDate = c.getTime()
        c.setTime(maxDate)
        c.add(Calendar.DATE, 1)
        maxDate = c.getTime()

        def projects =  Project.findAllByNameIlikeAndDateCreatedBetween(query, minDate, maxDate, [sort: "lastUpdated", order: "desc"])

        def projectApplications
        if(params.closingFrom || params.closingTo)
            projectApplications = checkProjectApplicationClosingDates(params, query, minDate, maxDate)
        else
            projectApplications = ProjectApplication.findAllByNameIlikeAndEntryDateBetween(query, minDate, maxDate,[sort: "lastUpdated", order: "desc"])

        def milestones = []
        if(params.closingFrom || params.closingTo)
            milestones = checkMilestoneClosingDates(params, query, minDate, maxDate)
        else{
            def myProjectApplicationList = ProjectApplication.findAllByClosingDateIsNull([sort: "deadline", order: "asc"])
            myProjectApplicationList.each { projectApplication ->
                projectApplication?.workPlan?.milestones?.each { milestone ->
                    if(!milestone.dateFinished && (milestone.name.contains(params.text) || milestone?.description?.contains(params.text)) &&
                    milestone.dateCreated.after(minDate) && milestone.dateCreated.before(maxDate)) {
                        milestones.add(milestone)
                    }
                }
            }
        }

        milestones = checkMilestonesEstimatedCost(params, milestones)

        def institutions = Institution.findAllByNameIlikeAndDateCreatedBetween(query, minDate, maxDate, [sort: "dateCreated", order: "desc"])
        def persons =  Person.findAllByNameIlikeAndDateCreatedBetween(query, minDate, maxDate, [sort: "dateCreated", order: "desc"])

        return [ projects: projects,
                    projectApplications: projectApplications,
                    milestones: milestones,
                    institutions: institutions,
                    persons: persons ]

    }
    
    private def checkProjectApplicationClosingDates(params, query, minDate, maxDate){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        Date minClosingDate = sdf.parse('01/01/1950')
        Date maxClosingDate = new Date()

        if(params.closingFrom) minClosingDate = sdf.parse(params.closingFrom)
        if(params.closingTo) maxClosingDate = sdf.parse(params.closingTo)

        Calendar c = Calendar.getInstance()
        c.setTime(minClosingDate)
        c.add(Calendar.DATE, 1)
        minClosingDate = c.getTime()
        c.setTime(maxClosingDate)
        c.add(Calendar.DATE, 1)
        maxClosingDate = c.getTime()

        return ProjectApplication.findAllByNameIlikeAndDateCreatedBetweenAndClosingDateBetween(query, minDate, maxDate, minClosingDate, maxClosingDate, [sort: "lastUpdated", order: "desc"])
    }

    private def checkMilestoneClosingDates(params, query, minDate, maxDate){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        Date minClosingDate = sdf.parse('01/01/1950')
        Date maxClosingDate = new Date()

        if(params.closingFrom) minClosingDate = sdf.parse(params.closingFrom)
        if(params.closingTo) maxClosingDate = sdf.parse(params.closingTo)

        Calendar c = Calendar.getInstance()
        c.setTime(minClosingDate)
        c.add(Calendar.DATE, 1)
        minClosingDate = c.getTime()
        c.setTime(maxClosingDate)
        c.add(Calendar.DATE, 1)
        maxClosingDate = c.getTime()

        def milestones = []
        def myProjectApplicationList = ProjectApplication.findAllByDateCreatedBetween(minDate, maxDate, [sort: "deadline", order: "asc"])
        myProjectApplicationList.each { projectApplication ->
            projectApplication?.workPlan?.milestones?.each { milestone ->
                if(milestone.dateFinished &&
                        (milestone.dateFinished.before(maxClosingDate) && milestone.dateFinished.after(minClosingDate)) &&
                        (milestone.name.contains(params.text) || milestone.description.contains(params.text))) {
                    milestones.add(milestone)
                }
            }
        }

        return milestones
    }

    private def checkMilestonesEstimatedCost(params, milestones){
        def min = params.estimatedLower ? Integer.parseInt(params.estimatedLower) : Integer.MIN_VALUE
        def max = params.estimatedGreater ? Integer.parseInt(params.estimatedGreater) : Integer.MAX_VALUE

        def returnList = []
        milestones.each{ milestone ->
            if(milestone.estimatedTime <= max && milestone.estimatedTime > min)
                returnList.add(milestone)
        }
        return returnList
    }

}
