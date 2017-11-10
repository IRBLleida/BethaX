import org.springframework.security.authentication.CredentialsExpiredException

grails.plugin.springsecurity.failureHandler.exceptionMappings = [
        [exception: CredentialsExpiredException.name, url: '/user/passwordExpired']
]
