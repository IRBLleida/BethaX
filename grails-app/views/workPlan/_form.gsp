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
    <div class="col-md-12">
        <div class="form-group">
            <label>Document del pla de treball</label>
            <label class="custom-file form-control">
                <input type="file" id="workPlanFile" name="workPlanFile" class="custom-file-input">
                <span class="custom-file-control form-control-file"></span>
            </label>
        </div>
    </div>
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
