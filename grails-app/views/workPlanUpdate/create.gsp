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
                <h4 class="card-title">Nova actualització de pla de treball</h4>
                <hr class="brace">
                <g:uploadForm action="save">
                    <g:render template="form"/>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="create" value="${message(code: 'default.button.create.label')}" class="btn btn-outline-primary" />
                            <g:link controller="workPlan" action="show" id="${this.workPlanUpdate.workPlan.id.toString()}" class="btn btn-outline-secondary">
                                <g:message code="default.button.cancel" />
                            </g:link>
                        </div>
                    </div>
                </g:uploadForm>
            </div>
        </div>
    </div>
</div>
</body>
</html>
