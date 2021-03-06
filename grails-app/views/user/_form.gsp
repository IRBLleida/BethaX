<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.user}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.user}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.user}" property="username" />
    <bx:formField bean="${this.user}" property="givenName" />
    <bx:formField bean="${this.user}" property="familyName" />
    <bx:formField bean="${this.user}" property="position" />
    <bx:formField bean="${this.user}" property="website" />
    <bx:formField bean="${this.user}" property="biography" />
    <div class="col-md-3">
        <div class="form-group">
            <label>Foto</label>
            <label class="custom-file form-control">
                <input type="file" id="photo" name="photo" class="custom-file-input" aria-describedby="photoHelpBlock">
                <span class="custom-file-control form-control-file"></span>
            </label>
            <small id="photoHelpBlock" class="form-text text-muted">
                Mida recomanda: 128 x 128 píxels.
            </small>
        </div>
    </div>
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
