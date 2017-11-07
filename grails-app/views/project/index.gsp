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
                    <th>#</th>
                    <th><g:message code="project.name.label" /></th>
                    <th><g:message code="project.principalInvestigator.label" /></th>
                    <th><g:message code="project.isResearch.label" /></th>
                    <th># Sol·licituds</th>
                </tr>
                </thead>
                <tbody>
                    <g:each var="project" in="${projectList}">
                        <tr>
                            <th scope="row">
                                <g:link action="show" id="${project.id.toString()}">
                                    ${project.id.toString().take(5)}...</th>
                                </g:link>
                            <td>${project.name}</td>
                            <td>${project.principalInvestigator}</td>
                            <td><g:message code="default.yesno.${project.isResearch}" /></td>
                            <td>${project.requests?.size() ?: 0}</td>
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
