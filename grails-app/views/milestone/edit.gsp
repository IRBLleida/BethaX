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
                <h4 class="card-title">Nova fita</h4>
                <hr class="brace">
                <g:form resource="${this.milestone}" method="PUT">
                    <g:hiddenField name="version" value="${this.milestone?.version}" />
                    <g:render template="form"/>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="update" value="${message(code: 'default.button.update.label')}" class="btn btn-outline-primary" />
                            <g:link controller="workPlan" action="show" id="${this.milestone.workPlan.id.toString()}" class="btn btn-outline-secondary">
                                <g:message code="default.button.cancel" />
                            </g:link>
                            <g:link action="delete" id="${this.milestone.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
