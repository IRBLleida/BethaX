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
                <bx:showField property="principalResearcher" bean="${this.serviceRequest}" />
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
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.serviceRequest.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
