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
        <h4 class="card-title">Les meves fites pendents</h4>
        <hr class="brace">
        <g:if test="${myOpenMilestones?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <g:sortableColumn property="workPlan" title="${message(code: 'milestone.workPlan.label')}"/>
                    <g:sortableColumn property="name" title="${message(code: 'milestone.name.label')}"/>
                    <g:sortableColumn property="description" title="${message(code: 'milestone.description.label')}"/>
                    <g:sortableColumn property="deadline" title="${message(code: 'milestone.deadline.label')}"/>
                    <g:sortableColumn property="estimatedTime" title="${message(code: 'milestone.estimatedTime.label')}"/>
                    <g:sortableColumn property="project" title="${message(code: 'project.label')}"/>
                    <g:sortableColumn property="projectApplication" title="${message(code: 'projectApplication.label')}"/></tr>
                </thead>
                <tbody>
                    <g:each var="milestone" in="${myOpenMilestones}">
                        <g:if test="${milestone.dte <= 0}"><g:set var="milestoneStyle" value="table-danger" /></g:if>
                        <g:elseif test="${milestone.dte <= 5}"><g:set var="milestoneStyle" value="table-warning" /></g:elseif>
                        <g:elseif test="${milestone.dte > 5}"><g:set var="milestoneStyle" value="table-primary" /></g:elseif>
                        <tr class="${milestoneStyle}">
                        <th scope="row">
                            <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                                ${milestone.workPlan}</th>
                            </g:link>
                            <td>${milestone.name}</td>
                            <td>${milestone.description?.take(60)}${milestone.description?.size() > 60 ? '...' : ''}</td>
                            <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                            <td>${milestone.estimatedTime}</td>
                            <td>
                                <g:link controller="projectApplication" action="show" id="${milestone?.workPlan?.projectApplication.id.toString()}">${milestone?.workPlan?.projectApplication} </g:link>
                            </td>
                            <td>
                                <g:each var="project" in="${milestone?.workPlan?.projectApplication?.projects}">
                                    <g:link controller="project" action="show" id="${project.id.toString()}">${project} </g:link>
                                </g:each>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <div class="row">
                <div class="col-md-12" style="margin-top: 30px;">
                    <g:paginate controller="milestone" action="index"  total="${openedMilestonesCount}" />
                </div>
            </div>
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
            <h4 class="card-title">Fites completades</h4>
            <hr class="brace">
            <table class="table">
                <thead class="thead-inverse">

                <tr>
                    <g:sortableColumn property="workPlan" title="${message(code: 'milestone.workPlan.label')}"/>
                    <g:sortableColumn property="name" title="${message(code: 'milestone.name.label')}"/>
                    <g:sortableColumn property="description" title="${message(code: 'milestone.description.label')}"/>
                    <g:sortableColumn property="estimatedTime" title="${message(code: 'milestone.estimatedTime.label')}"/>
                    <g:sortableColumn property="realTime" title="${message(code: 'milestone.realTime.label')}"/>
                    <g:sortableColumn property="deadline" title="${message(code: 'milestone.deadline.label')}"/>
                    <g:sortableColumn property="dateFinished" title="${message(code: 'milestone.dateFinished.label')}"/>
                    <g:sortableColumn property="project" title="${message(code: 'project.label')}"/>
                    <g:sortableColumn property="projectApplication" title="${message(code: 'projectApplication.label')}"/>
                </tr>
                </thead>
                <tbody>
                <g:each var="milestone" in="${myClosedMilestones}">
                    <tr class="table-success">
                        <td>
                            <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                                ${milestone.workPlan}
                            </g:link>
                        </td>
                        <td>${milestone.name}</td>
                        <td>${milestone.description?.take(60)}${milestone.description?.size() > 60 ? '...' : ''}</td>
                        <td>${milestone?.estimatedTime}</td>
                        <td>${milestone?.realTime ?: 'Desconegut'}</td>
                        <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                        <td><g:formatDate date="${milestone.dateFinished}" format="dd/MM/yyyy" /></td>
                        <td>
                            <g:link controller="projectApplication" action="show" id="${milestone?.workPlan?.projectApplication.id.toString()}">${milestone?.workPlan?.projectApplication} </g:link>
                        </td>
                        <td>
                            <g:each var="project" in="${milestone?.workPlan?.projectApplication?.projects}">
                                <g:link controller="project" action="show" id="${project.id.toString()}">${project} </g:link>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
            <div class="pull-right"><g:link action="closed"><i class="fa fa-eye"></i> Veure totes</g:link></div>
        </g:if>
    </div>
</div>
<content tag="footScripts">
    <g:javascript>
        $(document).ready(function() {
            $('#finishedMilestones').DataTable({
                "language": {
                    "lengthMenu": "Mostra _MENU_ fites per pàgina",
                    "zeroRecords": "No hi ha cap fita.",
                    "info": "Mostrant la pàgina _PAGE_ de _PAGES_",
                    "infoEmpty": "No s'ha trobat cap fita",
                    "infoFiltered": "(filtrades d'un total de _MAX_ fites)",
                    "search": "Cercar",
                    "paginate": {
                        "next": "Següent",
                        "previous": "Anterior"
                    }
                },
                "columnDefs": [
                    { type: 'date-eu', targets: 0 }
                ]
            });
        } );
    </g:javascript>
</content>
</body>
</html>
