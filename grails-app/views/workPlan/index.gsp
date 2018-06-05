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
        <h4 class="card-title">Llista de plans de treball</h4>
        <hr class="brace">
        <g:if test="${workPlanList?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <g:sortableColumn property="projectApplicationName" title="${message(code: 'workPlan.projectApplication.label')}"/>
                    <g:sortableColumn property="projectApplicationName" title="${message(code: 'projectApplication.projects.label')}"/>
                    <g:sortableColumn property="dateDone" title="${message(code: 'workPlan.dateDone.label')}"/>
                    <g:sortableColumn property="dateAccepted" title="${message(code: 'workPlan.dateAccepted.label')}"/>
                    <g:sortableColumn property="wpVersion" title="${message(code: 'workPlan.wpVersion.label')}"/>
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
                                ${workPlan.projectApplicationName}
                            </g:link>
                        </td>
                        <td>
                            <g:each var="project" in="${workPlan.projectApplication.projects}">
                                <g:link controller="project" action="show" id="${project.id.toString()}">${project} </g:link>
                            </g:each>
                        </td>
                        <td><g:formatDate date="${workPlan.dateDone}" format="dd/MM/yyyy" /></td>
                        <td><g:formatDate date="${workPlan.dateAccepted}" format="dd/MM/yyyy" /></td>
                        <td>${workPlan.wpVersion}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="row">
                <div class="col-md-12" style="margin-top: 30px;">
                    <g:paginate controller="workPlan" action="index" total="${workPlanCount}" />
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1 class="display-3">
                    <asset:image src="open-box.png" />
                    Ups ...
                </h1>
                <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "workPlan.label")?.toLowerCase()}!</p>
                <hr class="my-4">
                <p>Pots afegir-ne des d'una sol·licitud fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link controller="projectApplication" action="index" class="btn btn-outline-primary btn-lg">Anar a les sol·licituds</g:link>
                </p>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>
