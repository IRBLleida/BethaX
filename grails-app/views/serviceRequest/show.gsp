<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <style>
    summary {
        cursor: pointer;
    }
    details[open] summary {
        border-bottom: 1px dashed black;
        margin-bottom: 10px;
    }
    summary::-webkit-details-marker {
        display: none
    }
    summary:after {
        border-radius: 1px;
        content: "+";
        float: left;
        font-weight: bold;
        padding: 0;
        text-align: center;
        width: 20px;
    }
    details[open] summary:after {
        content: "-";
    }
    </style>
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Sol·licitud de serveis</h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="name" bean="${this.serviceRequest}" />
                <bx:showField property="department" bean="${this.serviceRequest}" />
                <bx:showField property="institution" bean="${this.serviceRequest}" />
                <bx:showField property="phone" bean="${this.serviceRequest}" />
                <bx:showField property="email" bean="${this.serviceRequest}" />
                <bx:showField property="researchProject" bean="${this.serviceRequest}" />
                <bx:showField property="primaryResearcher" bean="${this.serviceRequest}" />
                <bx:showField property="isCREC" bean="${this.serviceRequest}" />
                <bx:showField property="studyType" bean="${this.serviceRequest}" />
                <bx:showField property="otherStudyType" bean="${this.serviceRequest}" />
                <bx:showField property="studyObjective" bean="${this.serviceRequest}" />
                <bx:showField property="isCompetitiveProject" bean="${this.serviceRequest}" />
                <bx:showField property="isStudyDesign" bean="${this.serviceRequest}" />
                <bx:showField property="isPaperWriting" bean="${this.serviceRequest}" />
                <bx:showField property="isDatabaseDesign" bean="${this.serviceRequest}" />
                <bx:showField property="isDataAnalysis" bean="${this.serviceRequest}" />
                <bx:showField property="isOthers" bean="${this.serviceRequest}" />
                <bx:showField property="others" bean="${this.serviceRequest}" />
                <bx:showField property="comments" bean="${this.serviceRequest}" />
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.serviceRequest}" />
                            <bx:showField property="version" bean="${this.serviceRequest}" />
                            <bx:showField property="dateCreated" bean="${this.serviceRequest}" />
                            <bx:showField property="lastUpdated" bean="${this.serviceRequest}" />
                            <bx:showField property="lastModifiedBy" bean="${this.serviceRequest}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:if test="${this.serviceRequest.isApproved == null}">
                <g:link action="approve" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-success"><i class="fa fa-check" aria-hidden="true"></i> Aprovar</g:link>
                <g:link action="approveAndLink" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-primary"><i class="fa fa-link" aria-hidden="true"></i> Vincular a sol·licitud</g:link>
                <g:link action="reject" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-warning" onclick="return confirm('${message(code: 'default.button.refuse.confirm.message')}');"><i class="fa fa-times" aria-hidden="true"></i> Refusar</g:link>
            </g:if>
            <g:else>
                <g:if test="${this.serviceRequest.isApproved == false}">
                    <div class="alert alert-danger">
                        Aquesta petició està refusada, <g:link action="unrefuse" id="${this.serviceRequest.id.toString()}">fes clic aquí per tornar a obrir-li el cor <i class="fa fa-heart-o" aria-hidden="true"></i></g:link>.
                    </div>
                </g:if>
                <g:if test="${this.serviceRequest.isApproved == true && !this.serviceRequest.projectApplication}">
                    <div class="alert alert-success">
                        Aquesta petició està acceptada, <g:link action="unrefuse" id="${this.serviceRequest.id.toString()}">fes clic aquí per revocar la seva aprovació</g:link>.
                    </div>
                </g:if>
                <g:elseif test="${this.serviceRequest.isApproved == true && this.serviceRequest.projectApplication}">
                    <div class="alert alert-primary">
                        Aquesta petició està acceptada i vinculada a la sol·licitud <g:link controller="projectApplication" action="show" id="${this.serviceRequest.projectApplication.id.toString()}">${this.serviceRequest.projectApplication}</g:link>.
                    </div>
                </g:elseif>
            </g:else>
            <g:link action="delete" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
