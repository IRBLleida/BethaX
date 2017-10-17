<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Institució <strong>${this.institution}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="name" bean="${this.institution}" />
                <bx:showField property="institutionType" bean="${this.institution}" />
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.institution}" />
                            <bx:showField property="version" bean="${this.institution}" />
                            <bx:showField property="dateCreated" bean="${this.institution}" />
                            <bx:showField property="lastUpdated" bean="${this.institution}" />
                            <bx:showField property="createdBy" bean="${this.institution}" />
                            <bx:showField property="lastModifiedBy" bean="${this.institution}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.institution.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.institution.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
