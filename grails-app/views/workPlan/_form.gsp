<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.workPlan}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.workPlan}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.workPlan}" property="projectApplication" value="${this.workPlan.projectApplication.id.toString()}"/>
    <bx:formField bean="${this.workPlan}" property="dateDone" />
    <bx:formField bean="${this.workPlan}" property="dateAccepted" />
    <bx:formField bean="${this.workPlan}" property="wpVersion" />
</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
