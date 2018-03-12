package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured
import groovy.time.TimeCategory

import java.text.DateFormatSymbols

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    def springSecurityService
    def mailService

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond User.list(params), model:[userCount: User.count()]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def show(User user) {
        def isHimself = false
        if (!user || user.id.equals(((User) getAuthenticatedUser()).id)){
            user = User.get(((User) getAuthenticatedUser()).id)
            isHimself = true
        }
        def milestones = Milestone.findAllByHeadStatisticianAndDateFinishedIsNull(user,  [sort: "deadline", order: "desc"])

        /*** Created and Closed Milestones per month ***/

        def tenMonthsAgo = Calendar.getInstance()
        DateFormatSymbols dfs = new DateFormatSymbols()
        String[] months = dfs.getMonths()

        def createdMilestones = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        def closedMilestones = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        def monthsString = [], monthHelper = []
        def i = 0


        use(groovy.time.TimeCategory) {
            for (i = 0; i<10 ;i++){
                tenMonthsAgo.setTime(new Date() - i.months)
                def mo = months[tenMonthsAgo.get(Calendar.MONTH)].replace('de ', '').replace("d’" , "")
                def ye = ( tenMonthsAgo.get(Calendar.YEAR) )
                monthsString.add(mo + " " + ye)
                monthHelper.add(tenMonthsAgo.get(Calendar.MONTH))
            }
        }

        monthHelper = monthHelper.reverse()

        def milestoneList = Milestone.findAllByDateCreatedGreaterThanEqualsAndHeadStatistician(tenMonthsAgo, user)
        def date = Calendar.getInstance()

        for (m in milestoneList){
            date.setTime(m.dateCreated)
            createdMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            if(m.dateFinished){
                date.setTime(m.dateFinished)
                closedMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            }
        }

        def projectApplicationList = ProjectApplication.findAllByHeadStatistician(user, params)


        respond user, model: [milestoneList: milestones, isHimself: isHimself, monthString: monthsString.reverse(),
                              createdMilestones: createdMilestones, closedMilestones: closedMilestones,
                              projectApplicationList: projectApplicationList]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def create() {
        respond new User(params)
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    @Transactional
    def save(User user) {
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (user.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond user.errors, view:'create'
            return
        }

        user.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*' { respond user, [status: CREATED] }
        }
    }

    def photo(User user) {
        if(!user) user = (User) getAuthenticatedUser()
        File img = new File("/opt/bethax/user/" + user?.id?.toString())
        if(!img.exists()) img = new File("/opt/bethax/user/no_photo")
        render file: img.newInputStream(), contentType: 'image/png'
        return
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit(User user) {
        respond user ?: User.get(((User) getAuthenticatedUser()).id)
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def settings(User user) {
        respond user ?: User.get(((User) getAuthenticatedUser()).id), username: session['SPRING_SECURITY_LAST_USERNAME']
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    @Transactional
    def update(User user) {
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (user.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond user.errors, view:'edit'
            return
        }

        user.save flush:true

        if(!params.photo.isEmpty()) {
            def folderPath = "/opt/bethax/user/" as String
            def path = "${folderPath}/${user.id}" as String
            def currentPhoto = new File(path)
            if(currentPhoto.exists()) currentPhoto.delete()
            params.photo.transferTo(new File(path))
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect user
            }
            '*'{ respond user, [status: OK] }
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    @Transactional
    def delete(User user) {

        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        user.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), user.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def passwordExpired() {
        [username: session['SPRING_SECURITY_LAST_USERNAME']]
    }

    def updatePassword(Boolean settings, String password, String password_new, String password_new_2) {
        String username = session['SPRING_SECURITY_LAST_USERNAME']

        def noUsernameController = 'login'
        def noUsernameAction = 'auth'
        def okController = 'login'
        def okAction = 'auth'
        def errorView = 'passwordExpired'

        if(settings){
            noUsernameController = 'user'
            noUsernameAction = 'settings'
            okController = 'project'
            okAction = 'index'
            errorView = 'settings'
        }

        if (!username) {
            flash.message = 'Sorry, an error has occurred'
            redirect controller: noUsernameController, action: noUsernameAction
            return
        }

        if (!password || !password_new || !password_new_2 || password_new != password_new_2 || password_new?.size() < 6 || password_new?.size() > 64) {
            flash.message = message(code: "user.updatePassword.invalidNew")
            render view: errorView, model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        User user = User.findByUsername(username)

        if (!springSecurityService?.passwordEncoder.isPasswordValid(user.password, password, null /*salt*/)) {
            flash.message = message(code: "user.updatePassword.currentIncorrect")
            render view: errorView, model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (springSecurityService?.passwordEncoder.isPasswordValid(user.password, password_new, null /*salt*/)) {
            flash.message = message(code: "user.updatePassword.incorrectDifferent")
            render view: errorView, model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        user.password = springSecurityService.encodePassword(password_new)
        user.passwordExpired = false
        user.save(failOnError: true) // if you have password constraints check them here

        sendMail {
            to username
            from "BethaX <no-reply@bethax.udl.cat>"
            subject "[BethaX] Canvi de contrasenya"
            html view: "/email/password_changed"
        }

        flash.message = message(code: "user.updatePassword.success")

        redirect controller: okController, action: okAction
    }

    def passwordReset() {
        String username = params?.username

        User user = User.findByUsername(username)

        if(user != null) {

            def generator = { String alphabet, int n ->
                new Random().with {
                    (1..n).collect { alphabet[ nextInt( alphabet.length() ) ] }.join()
                }
            }

            def token = generator( (('A'..'Z')+('0'..'9')).join(), 15 )

            def uTok = username + "__" + token

            user.passwordResetToken = uTok
            user.save flush: true

            sendMail {
                to username
                from "BethaX <no-reply@bethax.udl.cat>"
                subject "[BethaX] Reinici de Contrasenya"
                html view: "/email/password_reset", model: [token: uTok]
            }
        }

        flash.message = message(code: 'login.auth.resetEmailSent')
        redirect controller: 'login', action: 'auth'
    }

    def newPassword() {
        def uTok = params?.uTok
        def username = uTok.split('__')[0]

        render view: 'newPassword', model: [username: username, uTok: uTok]
        return
    }

    def saveNewPassword() {
        String username = params?.username
        String token = params?.uTok
        String password1 = params?.password_new
        String password2 = params?.password_new_2

        User user = User.findByUsernameAndPasswordResetToken(username, token)

        if(user != null && password1 && password2 && password1 == password2) {
            user.password = springSecurityService.encodePassword(password1)
            user.passwordResetToken = null
            user.save()
            flash.message = message(code: 'login.auth.passwordResetSuccess')
        }

        redirect controller: 'login', action: 'auth'
        return
    }
}
