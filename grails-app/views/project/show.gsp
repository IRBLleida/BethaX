<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <style>
        summary {
            cursor: pointer;
        }
        details[open] summary {
            border-bottom: 1px dashed black;
            margin-bottom: 10px;
        }
        summary::-webkit-details-marker {
            display: none
        }
        summary:after {
            border-radius: 1px;
            content: "+";
            float: left;
            font-weight: bold;
            padding: 0;
            text-align: center;
            width: 20px;
        }
        details[open] summary:after {
            content: "-";
        }
    </style>
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
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
                                - <g:link controller="projectApplication" action="show" id="${projectApplication.id.toString()}">${projectApplication}</g:link>
                            </dd>
                        </g:each>
                        <dd class="sliding-middle-out">
                            <g:link controller="projectApplication" action="create" params="[projects: [this.project.id.toString()]]">
                                <i class="fa fa-plus" aria-hidden="true"></i>
                                Afegir sol·licitud
                            </g:link>
                        </dd>
                    </dl>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.project}" />
                            <bx:showField property="version" bean="${this.project}" />
                            <bx:showField property="dateCreated" bean="${this.project}" />
                            <bx:showField property="lastUpdated" bean="${this.project}" />
                            <bx:showField property="createdBy" bean="${this.project}" />
                            <bx:showField property="lastModifiedBy" bean="${this.project}" />
                        </div>
                    </details>
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
