<%@ page import="org.irblleida.bethax.Person" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.institution}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.institution}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.institution}" property="name" />
    <bx:formField bean="${this.institution}" property="institutionType" />
</div>
<content tag="footScripts">

</content>
