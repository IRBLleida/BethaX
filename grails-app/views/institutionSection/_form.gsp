<%@ page import="org.irblleida.bethax.Institution" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.institutionSection}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.institutionSection}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.institutionSection}" property="institution" required="required" />
    <bx:formField bean="${this.institutionSection}" property="name" required="required" />
</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
