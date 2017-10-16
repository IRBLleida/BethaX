<%@ page import="org.irblleida.bethax.Person" %>
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
<div class="row">
    <bx:formField bean="${this.projectApplication}" property="entryDate" />
    <bx:formField bean="${this.projectApplication}" property="name" />
    <bx:formField bean="${this.projectApplication}" property="description" width="6" />
    <bx:formField bean="${this.projectApplication}" property="linkedApplication" />
    <bx:formField bean="${this.projectApplication}" property="applicationType" />
    <bx:formField bean="${this.projectApplication}" property="applicant" />
    <bx:formField bean="${this.projectApplication}" property="headStatistician" />
    <bx:formField bean="${this.projectApplication}" property="budget" />
    <bx:formField bean="${this.projectApplication}" property="isWorkPlanNeeded" />
    <bx:formField bean="${this.projectApplication}" property="noWorkPlanReason" />
    <bx:formField bean="${this.projectApplication}" property="workPlan" />
    <bx:formField bean="${this.projectApplication}" property="applicant" width="3" type="select" from="${org.irblleida.bethax.Person.list()}" optionKey="id" noSelection="['': message(code: 'default.noSelection')]" value="${this.projectApplication.applicant?.id}" />
</div>
<!-- Modal -->
<div class="modal fade" id="createPrincipalInvestigatorModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Nou Investigador Principal</h5>
                <g:set var="person" value="${new org.irblleida.bethax.Person()}" />
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <bx:formField property="name" bean="${person}" />
                <bx:formField property="phone" bean="${person}" />
                <bx:formField property="email" bean="${person}" />
                <bx:formField property="institution" bean="${person}" />
                <bx:formField property="section" bean="${person}" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
<content tag="footScripts">
    <g:javascript>
        $('#principalInvestigator')
                .append($("<option></option>")
                .attr("value", 'newPrincipalInvestigator')
                .text('+ Afegir nou'));

        $('#principalInvestigator').change(function() {
            if ($(this).val() === 'newPrincipalInvestigator') {
                $('#createPrincipalInvestigatorModal').modal();
                $(this).val('');
            }
        });
    </g:javascript>
</content>
