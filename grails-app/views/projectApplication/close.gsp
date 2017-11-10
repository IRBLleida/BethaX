<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Tancament de la sol·licitud <strong>${this.projectApplication}</strong></h4>
            <hr class="brace">
            <div class="row">
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
            </div>
            <g:form action="update">
                <g:hiddenField name="id" value="${this.projectApplication?.id.toString()}" />
                <g:hiddenField name="version" value="${this.projectApplication?.version}" />
                <div class="row">
                    <bx:formField bean="${this.projectApplication}" property="closingDate" />
                    <bx:formField bean="${this.projectApplication}" property="closingComments" width="9" />
                    <bx:formField bean="${this.projectApplication}" property="isInvoiceIssued" />
                    <bx:formField bean="${this.projectApplication}" property="invoiceAmount" addon="€" />
                    <bx:formField bean="${this.projectApplication}" property="invoiceDate" />
                    <bx:formField bean="${this.projectApplication}" property="invoicePaymentDate" />
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <hr />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <g:submitButton name="finish" value="${message(code: 'default.button.finish.label')}" class="btn btn-outline-primary" />
                        <g:link action="show" id="${this.projectApplication.id.toString()}" class="btn btn-outline-secondary">
                            <g:message code="default.button.cancel" />
                        </g:link>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>
