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
    <bx:formField bean="${this.project}" property="name" width="3" />
    <bx:formField bean="${this.project}" property="description" width="9" />
    <bx:formField bean="${this.project}" property="isCREC" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" />
    <bx:formField bean="${this.project}" property="isFunded" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" />
    <bx:formField bean="${this.project}" property="isResearch" width="3" type="select" from="${[true, false]}" prefix="default.yesno" noSelection="['': message(code: 'default.noSelection')]" />
    <bx:formField bean="${this.project}" property="principalInvestigator" width="3" type="select" from="${org.irblleida.bethax.Person.list()}" optionKey="id" noSelection="['': message(code: 'default.noSelection')]" value="${this.project.principalInvestigator?.id}" />
</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
