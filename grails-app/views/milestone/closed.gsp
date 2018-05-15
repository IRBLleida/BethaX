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
        <h4 class="card-title">Últimes fites completades</h4>
        <hr class="brace">
        <table class="table">
            <thead class="thead-inverse">
            <tr>
                <th>#</th>
                <g:sortableColumn property="name" title="${message(code: 'milestone.name.label')}"/>
                <g:sortableColumn property="description" title="${message(code: 'milestone.description.label')}"/>
                <g:sortableColumn property="estimatedTime" title="${message(code: 'milestone.estimatedTime.label')}"/>
                <g:sortableColumn property="deadline" title="${message(code: 'milestone.name.label')}"/>
                <g:sortableColumn property="dateFinished" title="${message(code: 'milestone.dateFinished.label')}"/>
                <g:sortableColumn property="workPlan" title="${message(code: 'milestone.workPlan.label')}"/>
            </tr>
            </thead>
            <tbody>
            <g:each var="milestone" in="${myClosedMilestones}">
                <tr class="table-success">
                <th scope="row">
                    <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                        ${milestone.id.toString().take(10)}...</th>
                    </g:link>
                    <td>${milestone.name}</td>
                    <td>${milestone.description?.take(60)}${milestone.description?.size() > 60 ? '...' : ''}</td>
                    <td>${milestone?.estimatedTime}</td>
                    <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                    <td><g:formatDate date="${milestone.dateFinished}" format="dd/MM/yyyy" /></td>
                    <td>${milestone.workPlan}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
        <div class="row">
            <div class="col-md-12" style="margin-top: 30px;">
                <g:paginate controller="milestone" action="index"  total="${milestonesCount}" />
            </div>
        </div>
        <hr />
    </div>
</div>
</body>
</html>
