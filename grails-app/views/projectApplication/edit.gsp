<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body crud">
                <h4 class="card-title">Modificar sol·licitud</h4>
                <hr class="brace">
                <g:form action="update">
                    <g:hiddenField name="id" value="${this.projectApplication?.id.toString()}" />
                    <g:hiddenField name="version" value="${this.projectApplication?.version}" />
                    <g:render template="form"/>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="update" value="${message(code: 'default.button.update.label')}" class="btn btn-outline-primary" />
                            <g:link action="show" id="${this.projectApplication.id.toString()}" class="btn btn-outline-secondary">
                                <g:message code="default.button.cancel" />
                            </g:link>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
