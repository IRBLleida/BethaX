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
<div class="alert alert-info" role="alert">
    <strong>Cerca:</strong> ${search}
</div>
<g:if test="${(!projects || projects?.size() == 0) && (!projectApplications || projectApplications?.size() == 0) && (!milestones ||milestones?.size() == 0) && (!institutions || institutions?.size() == 0) && (!persons || persons?.size() == 0)}">
    <div class="card" style="margin-top: 15px">
            <div class="card-body crud">
                <h4 class="card-title">Cerca sense resultats...</h4>
                <hr class="brace">
                <div class="row justify-content-md-center">
                        <g:link controller="search" action="advanced" class="btn btn-outline-info t">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                            Tornar enrere
                        </g:link>
                </div>
        </div>
    </div>
</g:if>


<g:if test="${projects?.size() > 0}">
    <div class="card" style="margin-top: 15px">
        <div class="card-body crud">
            <h4 class="card-title">Llista de projectes</h4>
            <hr class="brace">
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
                <g:each var="project" in="${projects}">
                    <tr>
                    <th scope="row">
                        <g:link controller="project" action="show" id="${project.id.toString()}">
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
        </div>
    </div>
</g:if>

<g:if test="${projectApplications?.size() > 0}">
    <div class="card" style="margin-top: 15px">
        <div class="card-body crud">
            <h4 class="card-title">Llista de sol·licituds</h4>
            <hr class="brace">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th><g:message code="projectApplication.entryDate.label" /></th>
                    <th><g:message code="projectApplication.name.label" /></th>
                    <th><g:message code="projectApplication.applicant.label" /></th>
                    <th><g:message code="projectApplication.status.label" /></th>
                    <th><g:message code="projectApplication.projects.label" /></th>
                </tr>
                </thead>
                <tbody>
                <g:each var="projectApplication" in="${projectApplications}">
                    <tr>
                        <th scope="row">
                            <g:link controller="projectApplication" action="show" id="${projectApplication.id.toString()}">
                                <g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" />
                            </g:link>
                        <td>${projectApplication.name}</td>
                        <td>${projectApplication.applicant}</td>
                        <td>
                            <g:if test="${projectApplication.closingDate}">
                                <i class="fa fa-file-archive-o" aria-hidden="true"></i> Tancada
                            </g:if>
                            <g:else>
                                <i class="fa fa-folder-open-o" aria-hidden="true"></i> Oberta
                            </g:else>
                        </td>
                        <td>
                            <g:each var="project" in="${projectApplication.projects}">
                                <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</g:if>

<g:if test="${milestones?.size() > 0}">
    <div class="card" style="margin-top: 15px">
        <div class="card-body crud">
            <h4 class="card-title">Llista de fites</h4>
            <hr class="brace">
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
                <g:each var="milestone" in="${milestones}">
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
        </div>
    </div>
</g:if>

<g:if test="${institutions?.size() > 0}">
    <div class="card" style="margin-top: 15px">
        <div class="card-body crud">
            <h4 class="card-title">Llista d'institucions</h4>
            <hr class="brace">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>Institució</th>
                    <th>Tipus</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="institution" in="${institutions}">
                    <tr>
                        <td>
                            <g:link controller="institution" action="show" id="${institution.id.toString()}">
                                ${institution.name}
                            </g:link>
                        </td>
                        <td>
                            <g:message code="enum.institutionType.value.${institution.institutionType}"/>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</g:if>

<g:if test="${persons?.size() > 0}">
    <div class="card" style="margin-top: 15px">
        <div class="card-body crud">
            <h4 class="card-title">Llista de persones</h4>
            <hr class="brace">
            <div class="list-group" id="contact-list">
                <div class="row">
                    <g:each var="person" in="${persons}">
                        <div class="col-xs-12 col-md-6 personElement">
                            <div class="list-group-item">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-4 col-md-4">
                                        <g:link controller="person" action="show" id="${person.id.toString()}">
                                            <img src="${createLink(controller: 'person', action: 'photo', id: person.id.toString())}" width="128" height="128" alt="${person.name}" class="rounded-circle animated pulse" />
                                        </g:link>
                                    </div>
                                    <div class="col-xs-12 col-sm-8 col-md-8">
                                        <span class="name searchable">${person.name}</span><br/>
                                        <span class="c-info text-muted searchable">
                                            <i class="fa fa-building-o" aria-hidden="true"></i>
                                            ${person.institution} ${person.section ? '- ' + person.section : person.section}
                                        </span>
                                        <br />
                                        <span class="c-info text-muted searchable">
                                            <i class="fa fa-phone" aria-hidden="true"></i>
                                            ${person.phone}
                                        </span>
                                        <br />
                                        <span class="c-info text-muted searchable">
                                            <i class="fa fa-comments" aria-hidden="true"></i>
                                            <a href="mailto:${person.email}">${person.email}</a>
                                        </span>
                                        <br />
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </div>
        </div>
    </div>
</g:if>

<content tag="footScripts">
</content>
</body>
</html>