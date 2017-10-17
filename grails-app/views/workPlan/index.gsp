<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<h2><g:message code="default.list.label" args="[message(code: 'workPlan.label')?.toLowerCase()]" /></h2>


    <g:if test="${workPlanList?.size() > 0}">
        <table class="table">
            <thead class="thead-inverse">
            <tr>
                <th>#</th>
                <th><g:message code="workPlan.projectApplication.label" /></th>
                <th><g:message code="workPlan.dateDone.label" /></th>
                <th><g:message code="workPlan.dateAccepted.label" /></th>
                <th><g:message code="workPlan.wpVersion.label" /></th>
            </tr>
            </thead>
            <tbody>
                <g:each var="workPlan" in="${workPlanList}">
                    <tr>
                        <th scope="row">
                            <g:link action="show" id="${workPlan.id.toString()}">
                                ${workPlan.id.toString().take(5)}...</th>
                            </g:link>
                        <td>
                            <g:link controller="projectApplication" action="show" id="${workPlan.projectApplication.id.toString()}">
                                ${workPlan.projectApplication.name}
                            </g:link>
                        </td>
                        <td>${workPlan.dateDone}</td>
                        <td>${workPlan.dateAccepted}</td>
                        <td>${workPlan.wpVersion}</td>
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
            <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "workPlan.label")?.toLowerCase()}!</p>
            <hr class="my-4">
            <p>Pots afegir-ne fent clic al botó de sota.</p>
            <p class="lead">
                <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'workPlan.label')?.toLowerCase()]"/></g:link>
            </p>
        </div>
    </g:else>

</body>
</html>
