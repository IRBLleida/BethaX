<%@ page import="org.irblleida.bethax.Person" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.projectApplication}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.projectApplication}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.projectApplication}" property="applicant" />
    <div class="col-md-3">
        <label>&nbsp;</label>
        <g:link controller="person" action="create" class="btn btn-outline-success form-control"><i class="fa fa-user-plus" aria-hidden="true"></i> Nova investigadora</g:link>
    </div>
</div>
<div class="row">
    <bx:formField bean="${this.projectApplication}" property="entryDate" />
    <bx:formField bean="${this.projectApplication}" property="name" />
    <bx:formField bean="${this.projectApplication}" property="description" width="6" />
    <bx:formField bean="${this.projectApplication}" property="linkedApplication" />
    <bx:formField bean="${this.projectApplication}" property="applicationType" />
    <bx:formField bean="${this.projectApplication}" property="headStatistician" />
    <bx:formField bean="${this.projectApplication}" property="budget" addon="€" />
    <bx:formField bean="${this.projectApplication}" property="isWorkPlanNeeded" />
    <bx:formField bean="${this.projectApplication}" property="noWorkPlanReason" />
    <div class="col-md-3">
        <label for="projects">Projectes</label>
        <g:select name="projects" from="${org.irblleida.bethax.Project.list()}" multiple="multiple" value="${this.projectApplication.projects}" class="form-control" />
    </div>
</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
