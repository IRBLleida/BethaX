<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <h4 class="card-title">Crear <g:message code="institutionSection.label" /></h4>
                <g:form action="save">
                    <g:render template="form"/>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="create" value="${message(code: 'default.button.create.label')}" class="btn btn-outline-primary" />
                            <g:if test="${this.institutionSection.institution}">
                                <g:link controller="institution" action="show" id="${this.institutionSection.institution?.id?.toString()}" class="btn btn-outline-secondary">
                                    <g:message code="default.button.cancel" />
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link controller="institution" action="index" class="btn btn-outline-secondary">
                                    <g:message code="default.button.cancel" />
                                </g:link>
                            </g:else>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
