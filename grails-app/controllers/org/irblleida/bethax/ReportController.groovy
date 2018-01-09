package org.irblleida.bethax
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

import java.text.DateFormatSymbols
import java.text.SimpleDateFormat

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class ReportController {
    def wkhtmltoxService

    def options() {
        render view: 'options'
    }

    def generateReport(){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        Date from = sdf.parse(params.from)
        Date to = sdf.parse(params.to)

        // Afegim un dia a la data "to" per a que entri dins de la condicio "Between"
        Calendar c = Calendar.getInstance()
        c.setTime(to)
        c.add(Calendar.DATE, 1)
        to = c.getTime()

        // treiem un dia a la data "from" per a que entri dins de la condicio "Between"
        c.setTime(from)
        c.add(Calendar.DATE, -1)
        from = c.getTime()

        def milestones = Milestone.findAllByDateCreatedBetween(from, to)
        def closedMilestones = Milestone.findAllByDateFinishedBetween(from, to)
        def projectApplications = ProjectApplication.findAllByDateCreatedBetween(from, to)
        def closedProjectApplications = ProjectApplication.findAllByClosingDateBetween(from, to)
        def projects = Project.findAllByDateCreatedBetween(from, to)
        def serviceRequests = ServiceRequest.findAllByDateCreatedBetween(from, to)

        def internal = 0
        def pubExternal = 0
        def privExternal = 0

        for(ProjectApplication p in projectApplications){
            if(p.applicationType == InstitutionType.INTERNAL) internal += 1
            if(p.applicationType == InstitutionType.PUBLIC_EXTERNAL) pubExternal += 1
            if(p.applicationType == InstitutionType.PRIVATE_EXTERNAL) privExternal += 1
        }

        GregorianCalendar gcal = new GregorianCalendar()
        gcal.setTime(from)
        def calendar = Calendar.getInstance()
        DateFormatSymbols dfs = new DateFormatSymbols()
        String[] months = dfs.getMonths()
        def monthsString = [], monthHelper = []

        //Getting all months between "from" and "to" dates
        while (!gcal.getTime().after(to)) {
            Date d = gcal.getTime()
            calendar.setTime(d)
            def mo = months[calendar.get(Calendar.MONTH)].replace('de ', '').replace("d’" , "")
            def ye = ( calendar.get(Calendar.YEAR) )
            monthsString.add(mo + " " + ye)
            monthHelper.add(calendar.get(Calendar.MONTH))
            gcal.add(Calendar.MONTH, 1)
        }

        //Initialize arrays
        def createdMilestonesPerMonth = []
        def closedMilestonesPerMonth = []
        for(t in monthsString){
            createdMilestonesPerMonth.add(0)
            closedMilestonesPerMonth.add(0)
        }

        // Getting all User names
        def users = []
        def openMilestonesUser = []
        def costOpenMilestonesUser = []
        def closedMilestonesUser = []
        def costClosedMilestonesUser = []
        for(User u in User.findAll()){
            users.add(u.givenName + ' ' + u.familyName)
            openMilestonesUser.add(0)
            costOpenMilestonesUser.add(0)
            closedMilestonesUser.add(0)
            costClosedMilestonesUser.add(0)
        }


        //Information of created milestones
        for(Milestone m in milestones){
            calendar.setTime(m.dateCreated)
            createdMilestonesPerMonth[monthHelper.indexOf(calendar.get(Calendar.MONTH))] += 1
            openMilestonesUser[users.indexOf(m.headStatistician.givenName + ' ' + m.headStatistician.familyName)] += 1
            if(m.estimatedTime) costOpenMilestonesUser[users.indexOf(m.headStatistician.givenName + ' ' + m.headStatistician.familyName)] += m.estimatedTime
        }

        //Information of closed milestones
        for(Milestone m in closedMilestones){
            calendar.setTime(m.dateCreated)
            closedMilestonesPerMonth[monthHelper.indexOf(calendar.get(Calendar.MONTH))] += 1
            closedMilestonesUser[users.indexOf(m.headStatistician.givenName + ' ' + m.headStatistician.familyName)] += 1
            if(m.estimatedTime) costClosedMilestonesUser[users.indexOf(m.headStatistician.givenName + ' ' + m.headStatistician.familyName)] += m.estimatedTime
        }


        def pendingServiceRequests = 0
        def approvedServiceRequests = 0
        def refusedServiceRequests = 0

        for(ServiceRequest sr in serviceRequests){
            if(sr.isApproved == null) pendingServiceRequests += 1
            if(sr.isApproved == false) refusedServiceRequests += 1
            if(sr.isApproved == true) approvedServiceRequests += 1
        }

        byte[] pdfData = wkhtmltoxService.makePdf(
                view:"/report/generateReport",
                model:[
                        from: params.from,
                        to: params.to,
                        milestones: milestones,
                        closedMilestones: closedMilestones,
                        projectApplications: projectApplications,
                        closedProjectApplications: closedProjectApplications,
                        projects: projects,
                        serviceRequests: serviceRequests,
                        internal: internal,
                        pubExternal: pubExternal,
                        privExternal: privExternal,
                        createdMilestonesPerMonth: createdMilestonesPerMonth,
                        closedMilestonesPerMonth: closedMilestonesPerMonth,
                        monthString: monthsString.reverse(),
                        users: users,
                        openMilestonesUser: openMilestonesUser,
                        costOpenMilestonesUser: costOpenMilestonesUser,
                        closedMilestonesUser: closedMilestonesUser,
                        costClosedMilestonesUser: costClosedMilestonesUser,
                        pendingServiceRequests: pendingServiceRequests,
                        approvedServiceRequests: approvedServiceRequests,
                        refusedServiceRequests: refusedServiceRequests
                ],
                header:"/report/header",
                footer:"/report/footer",
                marginLeft:20,
                marginTop:35,
                marginBottom:20,
                marginRight:20,
                headerSpacing:10,
                enableJavascript: true,
                images: true,
                javascriptDelay: 500,
                encoding: 'UTF-8'
                //viewportSize: '1024x0',
                //disableSmartShrinking: true
                //dpi: 125
        )

        response.setHeader "Content-disposition", "inline; filename=Informe_BethaX_"+ from.format('dd_MM_yy') + "-" + to.format('dd_MM_yy') + ".pdf"
        response.contentType = 'application/pdf'
        response.outputStream << pdfData
        response.outputStream.flush()

    }

}
