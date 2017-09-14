package org.irblleida.bethax

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.servlet.LocaleResolver
import org.springframework.web.servlet.support.RequestContextUtils

@Secured(['IS_AUTHENTICATED_FULLY'])
class HomeController {

    def index() {
        if (!session.'org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE') {
            LocaleResolver localeResolver = RequestContextUtils.getLocaleResolver(request);
            localeResolver.setLocale(request, response, new Locale(principal.lang));
        }

        redirect controller: "project", action: "index"
    }
}
