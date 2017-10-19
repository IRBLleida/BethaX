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
        <h4 class="card-title">Llista de fites</h4>
        <hr class="brace">
        <g:if test="${milestoneList?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th><g:message code="milestone.name.label" /></th>
                    <th><g:message code="milestone.deadline.label" /></th>
                    <th><g:message code="milestone.dateFinished.label" /></th>
                    <th><g:message code="milestone.workPlan.label" /></th>
                </tr>
                </thead>
                <tbody>
                    <g:each var="milestone" in="${milestoneList}">
                        <tr>
                        <th scope="row">
                            <g:link action="show" id="${milestone.id.toString()}">
                                ${milestone.id.toString().take(5)}...</th>
                            </g:link>
                            <td>${milestone.name}</td>
                            <td>${milestone.deadline}</td>
                            <td>${milestone.dateFinished}</td>
                            <td>${milestone.workPlan}</td>
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
                <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "milestone.label")?.toLowerCase()}!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'milestone.label')?.toLowerCase()]" /></g:link>
                </p>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>
