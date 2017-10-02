<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.person}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.person}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField domain="person" name="name" value="${this.person.name}" width="4" />
    <bx:formField domain="person" name="email" value="${this.person.email}" width="4" />
    <bx:formField domain="person" name="phone" value="${this.person.phone}" width="4" />
    <bx:formField domain="person" name="institution" type="select" from="${org.irblleida.bethax.Institution.list()}" value="${this.person.institution}" width="4" />
</div>
