//grails.plugin.springsecurity.auth.forceHttps = true
//grails.plugin.springsecurity.secureChannel.useHeaderCheckChannelSecurity = true
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false
grails.plugin.springsecurity.apf.storeLastUsername = true
grails.plugin.springsecurity.userLookup.userDomainClassName = 'org.irblleida.bethax.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'org.irblleida.bethax.UserRole'
grails.plugin.springsecurity.authority.className = 'org.irblleida.bethax.Role'
grails.plugin.springsecurity.rememberMe.persistent = true
grails.plugin.springsecurity.rememberMe.persistentToken.domainClassName = 'org.irblleida.bethax.PersistentLogin'
grails.plugin.springsecurity.rememberMe.alwaysRemember = true
grails.plugin.springsecurity.rememberMe.tokenValiditySeconds = 2419200
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	//[pattern: '/oauth/authorize',access: "isFullyAuthenticated() and (request.getMethod().equals('GET') or request.getMethod().equals('POST'))"],
	//[pattern: '/oauth/token',    access: "isFullyAuthenticated() and request.getMethod().equals('POST')"],
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/fonts/**',    access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
	[pattern: '/login/**',       access: ['permitAll']],
	[pattern: '/logout/**',      access: ['permitAll']],
    //[pattern: '/oauth/error.gsp',       access: ['permitAll']],
    //[pattern: '/oauth/confirm_access.gsp',       access: ['permitAll']],
    //[pattern: '/**',      access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	//[pattern: '/oauth/token',    filters: 'JOINED_FILTERS,-oauth2ProviderFilter,-securityContextPersistenceFilter,-logoutFilter,-authenticationProcessingFilter,-rememberMeAuthenticationFilter,-exceptionTranslationFilter'],
    //[pattern: '/securedOAuth2Resources/**', filters: 'JOINED_FILTERS,-cookieSessionFilter, -securityContextPersistenceFilter,-logoutFilter,-authenticationProcessingFilter,-rememberMeAuthenticationFilter,-oauth2BasicAuthenticationFilter,-exceptionTranslationFilter'],
    [pattern: '/assets/**',      filters: 'none'],
    [pattern: '/**/js/**',       filters: 'none'],
    [pattern: '/**/css/**',      filters: 'none'],
    [pattern: '/**/images/**',   filters: 'none'],
    [pattern: '/**/favicon.ico', filters: 'none'],
    [pattern: '/**',             filters: 'JOINED_FILTERS']
    //[pattern: '/**',             filters: 'JOINED_FILTERS,-statelessSecurityContextPersistenceFilter,-oauth2ProviderFilter,-clientCredentialsTokenEndpointFilter,-oauth2BasicAuthenticationFilter,-oauth2ExceptionTranslationFilter']
]



// Added by the Spring Security OAuth2 Google Plugin:
//grails.plugin.springsecurity.oauth2.domainClass = 'org.irblleida.bethax.OAuthID'


grails {
	mail {
		host = "smtp.gmail.com"
		port = 465
		username = "bethax.ubiostat@gmail.com"
		password = "XVwu89s7AjUzfxkh"
		props = ["mail.smtp.auth":"true",
				 "mail.smtp.socketFactory.port":"465",
				 "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
				 "mail.smtp.socketFactory.fallback":"false"]
	}
}
