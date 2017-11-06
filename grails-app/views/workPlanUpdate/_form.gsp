<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.workPlanUpdate}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.workPlanUpdate}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.workPlanUpdate}" property="reasons" required="required" width="12" />
    <bx:formField bean="${this.workPlanUpdate}" property="updateDate" required="required" />
    <div class="col-md-9">
        <div class="form-group">
            <label>Document</label>
            <label class="custom-file form-control">
                <input type="file" id="document" name="document" class="custom-file-input">
                <span class="custom-file-control form-control-file"></span>
            </label>
        </div>
    </div>
    <g:hiddenField name="workPlan" value="${this.workPlanUpdate?.workPlan?.id?.toString()}" />
</div>
<content tag="footScripts">
    <g:javascript>
        $('.custom-file-input').on('change',function(){
            var fileName = $(this).val();
            if(fileName.length > 30) fileName = '... ' + fileName.substr(fileName.length - 27);
            $(this).next('.form-control-file').addClass("selected").html(fileName);
        });
    </g:javascript>
</content>
