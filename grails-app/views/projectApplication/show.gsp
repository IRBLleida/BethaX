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
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
<div class="col-md-12">
    <g:if test="${projectApplication.isWorkPlanNeeded && projectApplication.workPlan == null}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
            <i class="fa fa-exclamation-triangle"></i> No hi ha pla de treball! <g:link class="alert-link" controller="workPlan" action="create" params="[projectApplication: this.projectApplication.id.toString()]"> Afegeix-ne un. </g:link>
        </div>
    </g:if>
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">
                Sol·licitud <strong>${this.projectApplication}</strong>
                <g:if test="${this.projectApplication.closingDate}">
                    <asset:image src="closed_stamp.png" style="float: right; margin-right: 30px;" />
                </g:if>
            </h4>
            <hr class="brace">
            <div class="row">
                <bx:showField bean="${this.projectApplication}" property="entryDate" />
                <bx:showField bean="${this.projectApplication}" property="name" />
                <bx:showField bean="${this.projectApplication}" property="description" width="6" />
                <bx:showField bean="${this.projectApplication}" property="linkedApplication" />
                <bx:showField bean="${this.projectApplication}" property="applicationType" />
                <bx:showField bean="${this.projectApplication}" property="applicant" />
                <bx:showField bean="${this.projectApplication}" property="headStatistician" />
                <bx:showField bean="${this.projectApplication}" property="budget" addon="€" />
                <bx:showField bean="${this.projectApplication}" property="isWorkPlanNeeded" />
                <g:if test="${this.projectApplication.isWorkPlanNeeded == false}">
                    <bx:showField bean="${this.projectApplication}" property="noWorkPlanReason" />
                </g:if>
            </div>
            <div class="row">
            <g:if test="${projectApplication.isWorkPlanNeeded}">
                <div class="col-md-6">
                    <dl class="animated fadeIn">
                        <dt>
                            <g:message code="projectApplication.workPlan.label" />
                        </dt>
                        <g:if test="${projectApplication.workPlan != null}">
                        <dd class="sliding-middle-out">
                            <g:link controller="workPlan" action="show" id="${projectApplication.workPlan.id.toString()}">${projectApplication.workPlan}</g:link>
                        </dd>
                        </g:if><g:else>
                        <dd class="sliding-middle-out">
                            <g:link controller="workPlan" action="create" params="[projectApplication: this.projectApplication.id.toString()]">
                                <i class="fa fa-plus" aria-hidden="true"></i>
                                Afegir pla de treball
                            </g:link>
                        </dd>
                        </g:else>
                    </dl>
                </div>
            </g:if>
                <div class="col-md-6">
                    <dl class="animated fadeIn">
                        <dt>
                            <g:message code="projectApplication.projects.label" />
                        </dt>
                        <g:each var="project" in="${projectApplication.projects}">
                            <dd class="sliding-middle-out">
                                <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                            </dd>
                        </g:each>
                    </dl>
                </div>
            </div>
            <g:if test="${this.projectApplication.closingDate}">
                <div class="row">
                    <div class="col-md-12">
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <bx:showField property="closingDate" bean="${this.projectApplication}" />
                    <bx:showField property="closingComments" bean="${this.projectApplication}" width="9" />
                    <bx:showField property="isInvoiceIssued" bean="${this.projectApplication}" />
                    <bx:showField property="invoiceAmount" bean="${this.projectApplication}" addon="€" />
                    <bx:showField property="invoiceDate" bean="${this.projectApplication}" />
                    <bx:showField property="invoicePaymentDate" bean="${this.projectApplication}" />
                </div>
            </g:if>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.projectApplication}" />
                            <bx:showField property="version" bean="${this.projectApplication}" />
                            <bx:showField property="dateCreated" bean="${this.projectApplication}" />
                            <bx:showField property="lastUpdated" bean="${this.projectApplication}" />
                            <bx:showField property="createdBy" bean="${this.projectApplication}" />
                            <bx:showField property="lastModifiedBy" bean="${this.projectApplication}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.projectApplication.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="close" id="${this.projectApplication.id.toString()}" class="card-link btn btn-outline-secondary"><i class="fa fa-file-archive-o" aria-hidden="true"></i> Tancament</g:link>
            <g:link action="delete" id="${this.projectApplication.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>


<%--
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectApplication.label', default: 'ProjectApplication')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-projectApplication" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-projectApplication" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="alert alert-warning" role="alert">
                    ${flash.message}
                </div>
            </g:if>
            <f:display bean="projectApplication" />
            <g:form resource="${this.projectApplicationApplication}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.projectApplicationApplication}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
--%>