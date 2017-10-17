<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="col-md-12">
    <div class="card">
        <div class="card-body crud">
            <h4 class="card-title">Persona <strong>${this.person}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="name" bean="${this.person}" />
                <bx:showField property="phone" bean="${this.person}" />
                <bx:showField property="email" bean="${this.person}" />
                <bx:showField property="institution" bean="${this.person}" />
                <bx:showField property="section" bean="${this.person}" />
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.person}" />
                            <bx:showField property="version" bean="${this.person}" />
                            <bx:showField property="dateCreated" bean="${this.person}" />
                            <bx:showField property="lastUpdated" bean="${this.person}" />
                            <bx:showField property="createdBy" bean="${this.person}" />
                            <bx:showField property="lastModifiedBy" bean="${this.person}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link action="index" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar al llistat</g:link>
            <g:link action="edit" id="${this.person.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.person.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
</body>
</html>
