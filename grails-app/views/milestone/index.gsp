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
        <h4 class="card-title">Les meves fites pendents</h4>
        <hr class="brace">
        <g:if test="${myOpenMilestones?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th><g:message code="milestone.name.label" /></th>
                    <th><g:message code="milestone.description.label" /></th>
                    <th><g:message code="milestone.deadline.label" /></th>
                    <th><g:message code="milestone.workPlan.label" /></th>
                </tr>
                </thead>
                <tbody>
                    <g:each var="milestone" in="${myOpenMilestones}">
                        <g:if test="${milestone.dte <= 0}"><g:set var="milestoneStyle" value="table-danger" /></g:if>
                        <g:elseif test="${milestone.dte <= 5}"><g:set var="milestoneStyle" value="table-warning" /></g:elseif>
                        <g:elseif test="${milestone.dte > 5}"><g:set var="milestoneStyle" value="table-primary" /></g:elseif>
                        <tr class="${milestoneStyle}">
                        <th scope="row">
                            <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                                ${milestone.id.toString().take(10)}...</th>
                            </g:link>
                            <td>${milestone.name}</td>
                            <td>${milestone.description?.take(60)}${milestone.description?.size() > 60 ? '...' : ''}</td>
                            <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                            <td>${milestone.workPlan}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <hr />
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1 class="display-5">
                    <asset:image src="no_milestones.gif" width="100px" />
                    <span class="align-middle">Tot fet!</span>
                </h1>
                <p class="lead">Felicitats, no tens cap fita pendent.</p>
                <hr class="my-4">
                <p>Pots afegir-ne de noves des dels teus <g:link controller="workPlan" action="index">plans de treball</g:link>.</p>
            </div>
        </g:else>
        <g:if test="${myClosedMilestones?.size() > 0}">
            <h3>Fites completades</h3>
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th><g:message code="milestone.name.label" /></th>
                    <th><g:message code="milestone.description.label" /></th>
                    <th><g:message code="milestone.deadline.label" /></th>
                    <th><g:message code="milestone.dateFinished.label" /></th>
                    <th><g:message code="milestone.workPlan.label" /></th>
                </tr>
                </thead>
                <tbody>
                <g:each var="milestone" in="${myClosedMilestones.sort { it.dateFinished }}">
                    <tr class="table-success">
                    <th scope="row">
                        <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                            ${milestone.id.toString().take(10)}...</th>
                        </g:link>
                        <td>${milestone.name}</td>
                        <td>${milestone.description?.take(60)}${milestone.description.size() > 60 ? '...' : ''}</td>
                        <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                        <td><g:formatDate date="${milestone.dateFinished}" format="dd/MM/yyyy" /></td>
                        <td>${milestone.workPlan}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>
</div>
</body>
</html>
