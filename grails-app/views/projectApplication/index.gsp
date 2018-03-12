<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">Les meves sol·licituds</h4>
        <hr class="brace">


        <g:if test="${projectApplicationList?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <g:sortableColumn property="entryDate" title="${message(code: 'projectApplication.entryDate.label')}"/>
                    <g:sortableColumn property="name" title="${message(code: 'projectApplication.name.label')}"/>
                    <g:sortableColumn property="applicant" title="${message(code: 'projectApplication.applicant.label')}"/>
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
                            <td>${projectApplication.applicant}</td>
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
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1 class="display-3">
                    <asset:image src="open-box.png" />
                    Ups ...
                </h1>
                <p class="lead">Casum l'òs pedrer, encara no ets responsable de cap sol·licitud!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'projectApplication.label')?.toLowerCase()]" /></g:link>
                </p>
            </div>
        </g:else>
        <g:if test="${projectApplicationOthers?.size() > 0}">
            <hr />
            <h4 class="card-title">Altres sol·licituds</h4>
            <hr class="brace">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <g:sortableColumn property="entryDate" title="${message(code: 'projectApplication.entryDate.label')}"/>
                    <g:sortableColumn property="name" title="${message(code: 'projectApplication.name.label')}"/>
                    <g:sortableColumn property="applicant" title="${message(code: 'projectApplication.applicant.label')}"/>
                    <g:sortableColumn property="headStatistician" title="${message(code: 'projectApplication.headStatistician.label')}"/>
                    <g:sortableColumn property="status" title="${message(code: 'projectApplication.status.label')}"/>
                    <g:sortableColumn property="projects" title="${message(code: 'projectApplication.projects.label')}"/>
                </tr>
                </thead>
                <tbody>
                <g:each var="projectApplication" in="${projectApplicationOthers}">
                    <tr>
                    <th scope="row">
                        <g:link action="show" id="${projectApplication.id.toString()}">
                            <g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" />
                        </g:link>
                        <td>${projectApplication.name}</td>
                        <td>${projectApplication.applicant}</td>
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
            <div class="row">
                <div class="col-md-12" style="margin-top: 30px;">
                    <g:paginate controller="projectApplication" action="index" total="${projectApplicationOthersCount}" />
                </div>
            </div>
        </g:if>
    </div>
</div>
</body>
</html>
