<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">Llista de persones</h4>
        <hr class="brace">
        <table class="table">
            <thead class="thead-inverse">
            <tr>
                <th>#</th>
                <th><g:message code="person.name.label" /></th>
                <th><g:message code="person.phone.label" /></th>
                <th><g:message code="person.email.label" /></th>
                <th><g:message code="person.institution.label" /></th>
                <th><g:message code="person.section.label" /></th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${personList?.size() > 0}">
                <g:each var="person" in="${personList}">
                    <tr>
                    <th scope="row">
                        <g:link action="show" id="${person.id.toString()}">
                            ${person.id.toString().take(5)}...</th>
                        </g:link>
                        <td>${person.name}</td>
                        <td>${person.phone}</td>
                        <td>${person.email}</td>
                        <td>${person.institution}</td>
                        <td>${person.section}</td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <div class="jumbotron">
                    <h1 class="display-3">
                        <asset:image src="open-box.png" />
                        Ups ...
                    </h1>
                    <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "person.label")?.toLowerCase()}!</p>
                    <hr class="my-4">
                    <p>Pots afegir-ne fent clic al botó de sota.</p>
                    <p class="lead">
                        <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'person.label')?.toLowerCase()]" /></g:link>
                    </p>
                </div>
            </g:else>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
