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
                <div class="alert alert-primary alert-dismissible fade show" role="alert">
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
                <div class="col-md-3">
                    <img src="${createLink(action: 'photo', id: this.person.id.toString())}" width="128" height="128" alt="${this.person.name}" class="rounded-circle animated pulse" />
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <bx:showField property="name" bean="${this.person}" />
                        <bx:showField property="phone" bean="${this.person}" />
                        <bx:showField property="email" bean="${this.person}" />
                        <bx:showField property="institution" bean="${this.person}" />
                        <bx:showField property="section" bean="${this.person}" />
                    </div>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-12 mt-4">
                        <div class="card">
                            <div class="card-body crud">
                                <h5 class="card-title text-center">Sol·licituds</h5>
                                <hr class="brace">
                                <table class="table">
                                    <thead class="thead-inverse">
                                    <tr>
                                        <g:sortableColumn property="entryDate" title="${message(code: 'projectApplication.entryDate.label')}"/>
                                        <g:sortableColumn property="name" title="${message(code: 'projectApplication.name.label')}"/>
                                        <g:sortableColumn property="headStatistician" title="${message(code: 'projectApplication.headStatistician.label')}"/>
                                        <g:sortableColumn property="status" title="${message(code: 'projectApplication.status.label')}"/>
                                        <g:sortableColumn property="projects" title="${message(code: 'projectApplication.projects.label')}"/>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each var="projectApplication" in="${projectApplicationList}">
                                        <tr>
                                            <th scope="row">
                                                <g:link action="show" id="${projectApplication.id.toString()}">
                                                    <g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" />
                                                </g:link>
                                            <td>${projectApplication.name}</td>
                                            <td><g:link controller="user" action="show" id="${projectApplication.headStatistician?.id?.toString()}">${projectApplication.headStatistician}</g:link></td>
                                            <td>
                                                <g:if test="${projectApplication.closingDate}">
                                                    <i class="fa fa-file-archive-o" aria-hidden="true"></i> Tancada
                                                </g:if>
                                                <g:else>
                                                    <i class="fa fa-folder-open-o" aria-hidden="true"></i> Oberta
                                                </g:else>
                                            </td>
                                            <td>
                                                <g:each var="project" in="${projectApplication.projects}">
                                                    <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                                                </g:each>
                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
                <hr/>
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
