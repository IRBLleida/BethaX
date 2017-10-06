<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<h1><g:message code="default.list.label" args="[entityName]" /></h1>
<div class="jumbotron">
    <h1 class="display-3">Oops...</h1>
    <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "project.label")?.toLowerCase()}!</p>
    <hr class="my-4">
    <p>Pots afegir-ne fent clic al botó de sota.</p>
    <p class="lead">
        <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[entityName]" /></g:link>
    </p>
</div>
<table class="table">
    <thead class="thead-inverse">
    <tr>
        <th>#</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each var="project" in="${projectList}">
        <tr>
            <th scope="row">
                <g:link action="show" id="${project.id.toString()}">
                    ${project.id.toString().take(5)}</th>
                </g:link>
            <td></td>
        </tr>
    </g:each>
    </tbody>
</table>
</body>
</html>
