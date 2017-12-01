<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <style>
    summary {
        cursor: pointer;
    }
    details[open] summary {
        border-bottom: 1px dashed black;
        margin-bottom: 10px;
    }
    summary::-webkit-details-marker {
        display: none
    }
    summary:after {
        border-radius: 1px;
        content: "+";
        float: left;
        font-weight: bold;
        padding: 0;
        text-align: center;
        width: 20px;
    }
    details[open] summary:after {
        content: "-";
    }
    </style>
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Pla de treball <strong>${this.workPlan}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="projectApplication" bean="${this.workPlan}" />
                <bx:showField property="dateDone" bean="${this.workPlan}" />
                <bx:showField property="dateAccepted" bean="${this.workPlan}" />
                <bx:showField property="wpVersion" bean="${this.workPlan}" />
            </div>
            <div class="row">
                <div class="col-md-12">
                    <hr />
                    <g:if test="${workPlanFile}">
                        <g:link action="download" id="${this.workPlan.id.toString()}" target="_blank" class="border border-primary m-1 p-2">
                            <i class="fa fa-file-o" aria-hidden="true"></i>
                            Descarregar document pla de treball [${this.workPlan.filename}]
                        </g:link>
                    </g:if>
                    <g:else>
                        Aquest pla de treball no té cap document associat.
                    </g:else>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                Fites
                                <span class="pull-right">
                                    <g:link controller="milestone" action="create" params="[workPlan: this.workPlan.id]">
                                        <i class="fa fa-calendar-plus-o" aria-hidden="true"></i> Nova fita
                                    </g:link>
                                </span>
                            </h5>
                            <div class="row">
                                <div class="col-md-12">
                                    <g:if test="${this.workPlan.milestones}">
                                        <div class="list-group">
                                            <g:each var="milestone" in="${openMilestones.sort { it.deadline }}">
                                                <g:if test="${milestone.dte <= 0}"><g:set var="milestoneStyle" value="list-group-item-danger" /></g:if>
                                                <g:elseif test="${milestone.dte <= 5}"><g:set var="milestoneStyle" value="list-group-item-warning" /></g:elseif>
                                                <g:elseif test="${milestone.dte > 5}"><g:set var="milestoneStyle" value="list-group-item-primary" /></g:elseif>
                                                <g:link controller="milestone" action="edit" id="${milestone.id.toString()}" class="list-group-item list-group-item-action flex-column align-items-start ${milestoneStyle}">
                                                <div class="d-flex w-100 justify-content-between">
                                                    <h5 class="mb-1">${milestone}</h5>
                                                    <small>
                                                        <g:if test="${milestone.dte <= 0}">
                                                            Va expirar fa ${milestone.dte * -1} dies!
                                                        </g:if>
                                                        <g:else>
                                                            Expira en ${milestone.dte} dies.
                                                        </g:else>
                                                    </small>
                                                </div>
                                                <p class="mb-1">${milestone.description}</p>
                                                <small><g:message code="milestone.estimatedTime.label"/>: ${milestone.estimatedTime}<br/>
                                                Data límit: <g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /> <br/>
                                                Responsable: ${milestone.headStatistician.givenName} ${milestone.headStatistician.familyName}</small>
                                                </g:link>
                                            </g:each>
                                        </div>
                                        <hr />
                                        <div class="list-group">
                                            <g:each var="milestone" in="${closedMilestones.sort { it.dateFinished }}">
                                                <g:link controller="milestone" action="edit" id="${milestone.id.toString()}" class="list-group-item list-group-item-action flex-column align-items-start list-group-item-success">
                                                    <div class="d-flex w-100 justify-content-between">
                                                        <h5 class="mb-1">
                                                            <i class="fa fa-check-square-o" aria-hidden="true"></i>
                                                            ${milestone}
                                                        </h5>
                                                        <small>
                                                            Finalitzada en <g:formatDate date="${milestone.dateFinished}" format="dd/MM/yyyy" />
                                                        </small>
                                                    </div>
                                                    <p class="mb-1">${milestone.description}</p>
                                                    <small>
                                                        <g:if test="${milestone?.realTime}">
                                                            <g:message code="milestone.realTime.label"/>: ${milestone?.realTime}<br/>
                                                        </g:if>
                                                        Data límit: <g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /> <br/>
                                                        Responsable: ${milestone.headStatistician.givenName} ${milestone.headStatistician.familyName}</small>
                                                </g:link>
                                            </g:each>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <p>No s'ha definit cap fita, <g:link controller="milestone" action="create" params="[workPlan: this.workPlan.id]"> <i class="fa fa-map-signs" aria-hidden="true"></i>
                                            afegeix-ne una</g:link>.</p>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                Actualitzacions
                                <span class="pull-right">
                                    <g:link controller="workPlanUpdate" action="create" params="[workPlan: this.workPlan.id]">
                                        <i class="fa fa-plus-square" aria-hidden="true"></i> Nova actualització
                                    </g:link>
                                </span>
                            </h5>
                            <div class="row">
                                <div class="col-md-12">
                                    <g:if test="${this.workPlan.updates}">
                                        <div class="list-group">
                                            <g:each var="update" in="${this.workPlan.updates.sort { it.updateDate }}">
                                                <div class="list-group-item list-group-item-action flex-column align-items-start list-group-item-secondary">
                                                    <div class="d-flex w-100 justify-content-between">
                                                        <h5 class="mb-1"><g:link controller="workPlanUpdate" action="edit" id="${update.id.toString()}">${update}</g:link></h5>
                                                        <small>
                                                            <g:if test="${update.filename}">
                                                                <g:link controller="workPlanUpdate" action="download" id="${update.id.toString()}" target="_blank">
                                                                    <i class="fa fa-file" aria-hidden="true"></i>
                                                                    Document
                                                                </g:link>
                                                            </g:if>
                                                            <g:else>
                                                                Sense document associat.
                                                            </g:else>
                                                        </small>
                                                    </div>
                                                    <p class="mb-1"></p>
                                                    <small>Data de l'actualització: <g:formatDate date="${update.updateDate}" format="dd/MM/yyyy" /></small>
                                                </div>
                                            </g:each>
                                        </div>
                                    </g:if>
                                    <g:else>
                                        <p>Aquest pla de treball no té cap actualització, <g:link controller="workPlanUpdate" action="create" params="[workPlan: this.workPlan.id]">afegeix-ne una</g:link>.</p>
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.workPlan}" />
                            <bx:showField property="dateCreated" bean="${this.workPlan}" />
                            <bx:showField property="lastUpdated" bean="${this.workPlan}" />
                            <bx:showField property="createdBy" bean="${this.workPlan}" />
                            <bx:showField property="lastModifiedBy" bean="${this.workPlan}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.workPlan.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.workPlan.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
