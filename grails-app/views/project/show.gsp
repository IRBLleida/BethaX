<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Projecte <strong>${this.project}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="name" bean="${this.project}" />
                <bx:showField property="description" bean="${this.project}" />
                <bx:showField property="isResearch" bean="${this.project}" />
                <bx:showField property="principalInvestigator" bean="${this.project}" />
                <bx:showField property="principalInvestigator" bean="${this.project}" />
                <bx:showField property="isFunded" bean="${this.project}" />
                <bx:showField property="fundingBody" bean="${this.project}" />
                <bx:showField property="hasStatisticalFunding" bean="${this.project}" />
                <bx:showField property="isCREC" bean="${this.project}" />
            </div>
            <div class="row">
                <div class="col-md-12">
                    <dl class="animated fadeIn">
                        <dt>
                            <g:message code="project.requests.label" />
                        </dt>
                        <g:each var="projectApplication" in="${this.project.requests}">
                            <dd class="sliding-middle-out">
                                <g:link controller="projectApplication" action="show" id="${projectApplication.id.toString()}">${projectApplication}</g:link>
                            </dd>
                        </g:each>
                    </dl>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.project.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.project.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
