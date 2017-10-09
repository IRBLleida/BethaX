<%@ page import="org.irblleida.bethax.Person" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.project}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.project}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField domain="project" name="name" width="3" value="${this.project.name}" />
    <bx:formField domain="project" name="isCREC" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" value="${this.project.isCREC}" />
    <bx:formField domain="project" name="isFunded" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" value="${this.project.isFunded}" />
    <bx:formField domain="project" name="isResearch" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" value="${this.project.isResearch}" />
    <bx:formField domain="project" name="principalInvestigator" width="3" type="select" from="${org.irblleida.bethax.Person.list()}" optionKey="id" noSelection="['': message(code: 'default.noSelection')]" value="${this.project.principalInvestigator}" />
</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
