<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <g:if test="${flash.message}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${flash.message}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </g:if>
            <g:if test="${this.projects}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    Aquesta persona és investigadora principal dels següents projectes:
                    <g:each var="project" in="${projects}">
                        <span class="badge badge-light">
                            <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                        </span>
                    </g:each>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </g:if>
            <g:if test="${this.requests}">
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    Aquesta persona és investigadora principal de les següents sol·licituds:
                    <g:each var="request" in="${requests}">
                        <span class="badge badge-light">
                            <g:link controller="projectApplication" action="show" id="${request.id.toString()}">${request}</g:link>
                        </span>
                    </g:each>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </g:if>
            <h4 class="card-title"><strong>${this.person}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="name" bean="${this.person}" />
                <bx:showField property="phone" bean="${this.person}" />
                <bx:showField property="email" bean="${this.person}" />
                <bx:showField property="institution" bean="${this.person}" />
                <bx:showField property="section" bean="${this.person}" />
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.person}" />
                            <bx:showField property="version" bean="${this.person}" />
                            <bx:showField property="dateCreated" bean="${this.person}" />
                            <bx:showField property="lastUpdated" bean="${this.person}" />
                            <bx:showField property="createdBy" bean="${this.person}" />
                            <bx:showField property="lastModifiedBy" bean="${this.person}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.person.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.person.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
