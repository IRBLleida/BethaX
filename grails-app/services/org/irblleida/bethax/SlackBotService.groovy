package org.irblleida.bethax

import grails.converters.JSON
import grails.gorm.transactions.Transactional
import grails.plugins.rest.client.RestBuilder
import org.springframework.http.converter.StringHttpMessageConverter

import java.nio.charset.Charset

@Transactional
class SlackBotService {
    def grailsApplication

    def send(title, url, text){
        String webhook = grailsApplication.config.slack.webhook
        def rest = new RestBuilder()
        rest.restTemplate.setMessageConverters([ new StringHttpMessageConverter(Charset.forName("UTF-8")) ])

        def jsonObject = [
                //"text": "Noticia!",
                "attachments": [[
                        "color": url.contains("serviceRequest") ? "#36a64f": "#3687a6",
                        "title": title,
                        "title_link": url,
                        "text": text,
                ]]
        ]  as JSON


        rest.post(webhook) {
            header('Content-Type', 'application/json;charset=UTF-8')
            json jsonObject.toString()
        }
    }
}
