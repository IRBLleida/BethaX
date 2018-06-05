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
            <h4 class="card-title"><g:message code="institutionSection.label" /> <strong>${this.institutionSection}</strong></h4>
            <hr class="brace">
            <div class="row">
                <bx:showField property="institution" bean="${this.institutionSection}" />
                <bx:showField property="name" bean="${this.institutionSection}" />
            </div>
            <hr />
            <div class="row">
                <div class="col-md-6">
                    <br/>
                    <table class="table table-sm table-striped" id="projects-institution">
                        <thead>
                        <tr>
                            <th><g:message code="project.label" /></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="project" in="${projects}">
                            <tr><td><g:link controller="project" action="show" id="${project.id.toString()}">${project.name}</g:link></td></tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6">
                    <br/>
                    <table class="table table-sm table-striped" id="projectApplications-institution">
                        <thead>
                        <tr>
                            <th><g:message code="projectApplication.label" /></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="projectApplication" in="${projectApplications}">
                            <tr><td><g:link controller="project" action="show" id="${projectApplication.id.toString()}">${projectApplication.name}</g:link></td></tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-md-12">
                    <details>
                        <summary class="text-muted"><i class="fa fa-info-circle" aria-hidden="true"></i> Més detalls</summary>
                        <div class="row">
                            <bx:showField property="id" bean="${this.institutionSection}" />
                            <bx:showField property="version" bean="${this.institutionSection}" />
                            <bx:showField property="dateCreated" bean="${this.institutionSection}" />
                            <bx:showField property="lastUpdated" bean="${this.institutionSection}" />
                            <bx:showField property="createdBy" bean="${this.institutionSection}" />
                            <bx:showField property="lastModifiedBy" bean="${this.institutionSection}" />
                        </div>
                    </details>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <g:link controller="institution" action="show" id="${this.institutionSection.institution.id.toString()}" class="card-link btn btn-outline-primary"><i class="fa fa-list" aria-hidden="true"></i> Tornar</g:link>
            <g:link action="edit" id="${this.institutionSection.id.toString()}" class="card-link btn btn-outline-warning"><i class="fa fa-pencil-square-o" aria-hidden="true"></i> Modificar</g:link>
            <g:link action="delete" id="${this.institutionSection.id.toString()}" class="card-link btn btn-outline-danger pull-right" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');"><i class="fa fa-trash" aria-hidden="true"></i> Eliminar</g:link>
        </div>
    </div>
</div>
<content tag="footScripts">
    <g:javascript>
        $(document).ready(function() {
           $('#projects-institution').DataTable({
                "language": {
                    "lengthMenu": "Mostra _MENU_ projectes per pàgina",
                    "zeroRecords": "No hi ha cap projecte.",
                    "info": "Mostrant la pàgina _PAGE_ de _PAGES_",
                    "infoEmpty": "No s'ha trobat cap projecte",
                    "infoFiltered": "(filtrades d'un total de _MAX_ projectes)",
                    "search": "Cercar",
                    "paginate": {
                        "next": "Següent",
                        "previous": "Anterior"
                    }
                }
            });

            $('#projectApplications-institution').DataTable({
                "language": {
                    "lengthMenu": "Mostra _MENU_ sol·licituds per pàgina",
                    "zeroRecords": "No hi ha cap sol·licitud.",
                    "info": "Mostrant la pàgina _PAGE_ de _PAGES_",
                    "infoEmpty": "No s'ha trobat cap sol·licitud",
                    "infoFiltered": "(filtrades d'un total de _MAX_ sol·licituds)",
                    "search": "Cercar",
                    "paginate": {
                        "next": "Següent",
                        "previous": "Anterior"
                    }
                }
            });
        } );
    </g:javascript>
</content>
</body>
</html>
