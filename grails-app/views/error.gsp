<!doctype html>
<html>
    <head>
        <title><g:if env="development">Grails Runtime Exception</g:if><g:else>Error</g:else></title>
        <meta name="layout" content="main">
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
    </head>
    <body>
        %{--<g:if env="development">
            <g:if test="${Throwable.isInstance(exception)}">
                <g:renderException exception="${exception}" />
            </g:if>
            <g:elseif test="${request.getAttribute('javax.servlet.error.exception')}">
                <g:renderException exception="${request.getAttribute('javax.servlet.error.exception')}" />
            </g:elseif>
            <g:else>
                <ul class="errors">
                    <li>An error has occurred</li>
                    <li>Exception: ${exception}</li>
                    <li>Message: ${message}</li>
                    <li>Path: ${path}</li>
                </ul>
            </g:else>
        </g:if>
        <g:else>--}%
        <div class="jumbotron" style="text-align: center;">
            <h1 class="display-3">
                <asset:image src="error.gif" width="250px" />
            </h1>
            <h3 class="display-4">Hi ha hagut un error!</h3>
            <hr class="my-4">
            <p>Torna-ho a provar més tard o contacta amb els desenvolupadors.</p>

        </div>
%{--
        </g:else>
--}%
    </body>
</html>
