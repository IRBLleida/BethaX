<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <asset:stylesheet src="profile.css" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div id="show-user" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:form resource="${this.user}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.user}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>

            <div class="col-md-12">
                <div class="card card-01">
                    <div class="profile-box">
                        <img class="card-img-top rounded-circle" src="${resource(dir: 'images', file: 'user.png')}"  style="width:120px;height:120px;"/>
                    </div>
                    <div class="card-body text-center">
                        <h4 class="card-title"><sec:loggedInUserInfo field="givenName" /> <sec:loggedInUserInfo field="familyName" /></h4>
                        <p class="card-text">
                            <g:if test="${user.biography}">
                                ${user.biography}
                            </g:if><g:else>
                                <g:link class="edit" action="edit" resource="${this.user}">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                    Afegir biografia
                                </g:link>
                            </g:else>
                            <g:if test="${user.website}"><br/><a href="${user?.website}">(${user?.website})</a></g:if>
                        </p>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
