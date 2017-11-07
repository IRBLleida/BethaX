<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body crud">
                <h4 class="card-title">Nova sol·licitud</h4>
                <hr class="brace">
                <p class="text-info">
                    <strong>Tipus d'estudi:</strong> <g:message code="enum.studyType.value.${serviceRequest.studyType}" />
                <g:if test="${serviceRequest.studyType == org.irblleida.bethax.StudyType.OTHERS}">
                    : ${serviceRequest.otherStudyType}
                </g:if>
                </p>
                <p class="text-info"><strong>Objectiu de l'estudi:</strong> ${serviceRequest.studyObjective}</p>
                <p class="text-info"><strong>Servei / consulta:</strong>
                    <span class="badge badge-primary">${serviceRequest.isCompetitiveProject ? message(code: 'serviceRequest.isCompetitiveProject.label') :''}</span>
                    <span class="badge badge-primary">${serviceRequest.isStudyDesign ? message(code: 'serviceRequest.isStudyDesign.label') :''}</span>
                    <span class="badge badge-primary">${serviceRequest.isPaperWriting ? message(code: 'serviceRequest.isPaperWriting.label') :''}</span>
                    <span class="badge badge-primary">${serviceRequest.isDatabaseDesign ? message(code: 'serviceRequest.isDatabaseDesign.label') :''}</span>
                    <span class="badge badge-primary">${serviceRequest.isDataAnalysis ? message(code: 'serviceRequest.isDataAnalysis.label') :''}</span>
                    <span class="badge badge-primary">${serviceRequest.isOthers ? message(code: 'serviceRequest.isOthers.label') + ': ' + serviceRequest.others :''}</span>
                </p>
                <p class="text-info"><strong>Comentaris:</strong> ${serviceRequest.comments}</p>
                <g:form action="saveFromRequest">
                    <g:hiddenField name="serviceRequest" value="${serviceRequest?.id?.toString()}" />
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
                        <bx:formField bean="${this.projectApplication}" property="applicant" helpText="${serviceRequest.name} (${serviceRequest.institution} - ${serviceRequest.department})" />
                        <div class="col-md-3">
                            <label>&nbsp;</label>
                            <g:link controller="person" action="create" params="[name: serviceRequest.name, phone: serviceRequest.phone, email: serviceRequest.email]" class="btn btn-outline-success form-control"><i class="fa fa-user-plus" aria-hidden="true"></i> Nova investigadora</g:link>
                        </div>
                        <div class="col-md-3">
                            <label for="projects">Projectes</label>
                            <g:select name="projects" from="${org.irblleida.bethax.Project.list()}" multiple="multiple" value="${this.projectApplication.projects}" optionKey="id" class="form-control" />
                            <small class="form-text text-info">
                                <i class="fa fa-arrow-right" aria-hidden="true"></i>
                                ${serviceRequest.researchProject} (IP: ${serviceRequest.primaryResearcher}, CEIC: <g:message code="default.yesno.${serviceRequest.isCREC}" />)
                            </small>
                        </div>
                        <div class="col-md-3">
                            <label>&nbsp;</label>
                            <g:link controller="project" action="create" params="[name: serviceRequest.researchProject, isCREC: serviceRequest.isCREC]" class="btn btn-outline-success form-control"><i class="fa fa-user-plus" aria-hidden="true"></i> Nou projecte</g:link>
                        </div>
                    </div>
                    <div class="row">
                        <bx:formField bean="${this.projectApplication}" property="entryDate" helpText="${formatDate(date: serviceRequest.dateCreated, format: 'dd/MM/yyyy')}" />
                        <bx:formField bean="${this.projectApplication}" property="name" />
                        <bx:formField bean="${this.projectApplication}" property="description" width="6" />
                        <bx:formField bean="${this.projectApplication}" property="linkedApplication" />
                        <bx:formField bean="${this.projectApplication}" property="applicationType" />
                        <bx:formField bean="${this.projectApplication}" property="headStatistician" value="${this.projectApplication?.headStatistician?.id?.toString()}" />
                        <bx:formField bean="${this.projectApplication}" property="budget" addon="€" />
                        <bx:formField bean="${this.projectApplication}" property="isWorkPlanNeeded" />
                        <bx:formField bean="${this.projectApplication}" property="noWorkPlanReason" cssClass="isWorkPlanNeeded-only" />
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <hr />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <g:submitButton name="create" value="${message(code: 'default.button.create.label')}" class="btn btn-outline-primary" />
                            <g:link action="index" class="btn btn-outline-secondary">
                                <g:message code="default.button.cancel" />
                            </g:link>
                        </div>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
<content tag="footScripts">
    <g:javascript>
        $('#isWorkPlanNeeded').on("change", function() {
            if($(this).val() === 'true') {
                $('.isWorkPlanNeeded-only').hide();
                $('#noWorkPlanReason').removeAttr("selected");
            }
            else if($(this).val() === 'false') {
                $('.isWorkPlanNeeded-only').show();
            }
        });

        $('#isWorkPlanNeeded').change();
    </g:javascript>
</content>
</body>
</html>
