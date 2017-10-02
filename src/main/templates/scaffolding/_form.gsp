<g:if test="\${flash.message}">
    <div class="alert alert-info" role="alert">\${flash.message}</div>
</g:if>
<g:hasErrors bean="\${this.${propertyName}}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="\${this.${propertyName}}" var="error">
            <p <g:if test="\${error in org.springframework.validation.FieldError}">data-field-id="\${error.field}"</g:if>><g:message error="\${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
</div>
