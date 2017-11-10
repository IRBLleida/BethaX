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
        def milestones = Milestone.findAllByCreatedByAndDateFinishedIsNull(user,  [sort: "deadline", order: "desc"])

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

        def milestoneList = Milestone.findAllByDateCreatedGreaterThanEqualsAndCreatedBy(tenMonthsAgo, user)
        def date = Calendar.getInstance()

        for (m in milestoneList){
            date.setTime(m.dateCreated)
            createdMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            if(m.dateFinished){
                date.setTime(m.dateFinished)
                closedMilestones[monthHelper.indexOf(date.get(Calendar.MONTH))] += 1
            }
        }


        respond user, model: [milestoneList: milestones, isHimself: isHimself, monthString: monthsString.reverse(),
                              createdMilestones: createdMilestones, closedMilestones: closedMilestones,]
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

        if(params.photo) {
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

    def updatePassword(String password, String password_new, String password_new_2) {
        String username = session['SPRING_SECURITY_LAST_USERNAME']

        if (!username) {
            flash.message = 'Sorry, an error has occurred'
            redirect controller: 'login', action: 'auth'
            return
        }

        if (!password || !password_new || !password_new_2 || password_new != password_new_2 || password_new?.size() < 6 || password_new?.size() > 64) {
            flash.message = message(code: "user.updatePassword.invalidNew")
            render view: 'passwordExpired', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        User user = User.findByUsername(username)

        if (!springSecurityService?.passwordEncoder.isPasswordValid(user.password, password, null /*salt*/)) {
            flash.message = message(code: "user.updatePassword.currentIncorrect")
            render view: 'passwordExpired', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        if (springSecurityService?.passwordEncoder.isPasswordValid(user.password, password_new, null /*salt*/)) {
            flash.message = message(code: "user.updatePassword.incorrectDifferent")
            render view: 'passwordExpired', model: [username: session['SPRING_SECURITY_LAST_USERNAME']]
            return
        }

        user.password = springSecurityService.encodePassword(password_new)
        user.passwordExpired = false
        user.save(failOnError: true) // if you have password constraints check them here

        sendMail {
            to username
            from "BethaX <no-reply@bethax.com>"
            subject "[BethaX] Canvi de contrasenya"
            html view: "/email/password_changed"
        }

        flash.message = message(code: "user.updatePassword.success")

        redirect controller: 'login', action: 'auth'
    }
}
