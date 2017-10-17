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
                <h4 class="card-title">Modificar persona</h4>
                <hr class="brace">
                <g:form resource="${this.person}" method="PUT">
                    <g:hiddenField name="id" value="${this.person?.id.toString()}" />
                    <g:hiddenField name="version" value="${this.person?.version}" />
                    <g:render template="form"/>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="update" value="${message(code: 'default.button.update.label')}" class="btn btn-outline-primary" />
                            <g:link action="show" id="${this.person.id.toString()}" class="btn btn-outline-secondary">
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
