package org.irblleida.bethax
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Secured(['IS_AUTHENTICATED_FULLY'])
@Transactional(readOnly = true)
class ReportController {
    def wkhtmltoxService

    def options() {
        render view: 'options'
    }

    def generateReport(){
        params.form

        byte[] pdfData = wkhtmltoxService.makePdf(
                view:"/report/generateReport",
                //model:[
                //],
                //header:"/reports/header",
                //footer:"/reports/footer",
                marginLeft:20,
                marginTop:35,
                marginBottom:20,
                marginRight:20,
                headerSpacing:10,
                enableJavascript: true,
                images: true,
                javascriptDelay: 500,
                //viewportSize: '1024x0',
                dpi: 125,
                lowquality: false)

        response.setHeader "Content-disposition", "inline; filename="+new Date().toString()+""
        response.contentType = 'application/pdf'
        response.outputStream << pdfData
        response.outputStream.flush()

    }

}
