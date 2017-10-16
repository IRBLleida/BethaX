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
    <bx:formField domain="milestone" name="name" value="${this.milestone.name}" width="4" />
    <bx:formField domain="milestone" name="deadline" value="${this.milestone.deadline}" width="4" type="date"/>
    <bx:formField domain="milestone" name="workPlan" type="select" from="${org.irblleida.bethax.WorkPlan.list()}" value="${this.milestone.workPlan}" width="4" />

</div>
<content tag="footScripts">
    <g:javascript>

    </g:javascript>
</content>
