<%@ page import="org.irblleida.bethax.Person" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.milestone}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.milestone}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.milestone}" property="name" required="required" maxlength="30" tooltip="Aaaa" />
    <bx:formField bean="${this.milestone}" property="deadline" required="required" />
    <bx:formField bean="${this.milestone}" property="dateFinished" />
    <bx:formField bean="${this.milestone}" type="textarea" property="description" width="12" maxlength="500" />
    <g:hiddenField name="workPlan" value="${this.milestone?.workPlan?.id?.toString()}" />
    <%--<bx:formField bean="${this.milestone}" property="workPlan" value="${this.milestone?.workPlan?.id?.toString()}" />--%>
</div>
<content tag="footScripts">
    <g:javascript>
        $('#name').maxlength({
            warningClass: "badge badge-success",
            limitReachedClass: "badge badge-danger"
        });
        $('#description').maxlength({
            warningClass: "badge badge-success",
            limitReachedClass: "badge badge-danger"
        });
    </g:javascript>
</content>
