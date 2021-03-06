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
        <h4 class="card-title">Llista de projectes</h4>
        <hr class="brace">
        <g:if test="${projectList?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <g:sortableColumn property="name" title="${message(code: 'project.name.label')}"/>
                    <g:sortableColumn property="principalInvestigator" title="${message(code: 'project.principalInvestigator.label')}"/>
                    <g:sortableColumn property="isResearch" title="${message(code: 'project.isResearch.label')}"/>
                    <g:sortableColumn property="requests" title="# Sol·licituds"/>
                </tr>
                </thead>
                <tbody>
                    <g:each var="project" in="${projectList}">
                        <tr>
                            <td><b><g:link action="show" id="${project.id.toString()}">${project.name}</g:link></b></td>
                            <td>${project.principalInvestigator}</td>
                            <td><g:message code="default.yesno.${project.isResearch}" /></td>
                            <td>${project.requests?.size() ?: 0}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="row">
                <div class="col-md-12" style="margin-top: 30px;">
                    <g:paginate controller="project" action="index" total="${projectCount}" />
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1 class="display-3">
                    <asset:image src="open-box.png" />
                    Ups ...
                </h1>
                <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "project.label")?.toLowerCase()}!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'project.label')?.toLowerCase()]" /></g:link>
                </p>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>
