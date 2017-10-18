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
            <h4 class="card-title">Sol·licitud <strong>${this.projectApplication}</strong></h4>
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
                <bx:showField bean="${this.projectApplication}" property="noWorkPlanReason" />
            </div>
            <div class="row">
                <div class="col-md-12">
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
            </div>
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
            <div class="message" role="status">${flash.message}</div>
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