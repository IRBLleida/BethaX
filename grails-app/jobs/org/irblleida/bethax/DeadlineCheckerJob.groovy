package org.irblleida.bethax

class DeadlineCheckerJob {
    def slackBotService

    static triggers = {
        cron name:   'cronTrigger',   startDelay: 10000, cronExpression: '0 0 8 * * ?'
    }

    def execute() {
        def milestones = Milestone.findAllByHeadStatisticianAndDateFinishedIsNull()

        for(Milestone m: milestones){
            def notification = false

            if(m.dte < 3) notification = true
            if(m.dte == 7) notification = true

            if(notification){
                def description = "Nom: " + m.name +
                        "\nSol·licitud: " + m.workPlan.projectApplication.name +
                        "\nResponsable: " + m.headStatistician.givenName + m.headStatistician.familyName

                slackBotService.send('Una fita expira en ' + m.dte + ' dies', 'https://bethax.udl.cat/workPlan/show/' + m.workPlan.id.toString() , description)
            }
        }
    }
}
