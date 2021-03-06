<%@ page import="org.irblleida.bethax.Project; org.irblleida.bethax.Person" %>
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
    <bx:formField bean="${this.project}" property="principalInvestigator" required="required" />
    <div class="col-md-3">
        <label>&nbsp;</label>
        <g:link controller="person" action="create" class="btn btn-outline-success form-control"><i class="fa fa-user-plus" aria-hidden="true"></i> Nova investigadora</g:link>
    </div>
</div>
<div class="row">
    <bx:formField bean="${this.project}" property="name" />
    <bx:formField bean="${this.project}" property="description" width="9" />
    <bx:formField bean="${this.project}" property="isCREC" />
    <bx:formField bean="${this.project}" property="isFunded" />
    <bx:formField bean="${this.project}" property="isResearch" />

</div>
<%--
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
--%>
<content tag="footScripts">
    <g:javascript>
        <%--
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
        --%>
    </g:javascript>
</content>
