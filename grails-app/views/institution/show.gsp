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
                    <nav class="nav nav-tabs" id="myTab" role="tablist">
                        <a class="nav-item nav-link active" id="nav-sections-tab" data-toggle="tab" href="#nav-sections" role="tab" aria-controls="nav-sections" aria-expanded="true"><g:message code="institution.sections.label"/></a>
                        <a class="nav-item nav-link" id="nav-projects-tab" data-toggle="tab" href="#nav-projects" role="tab" aria-controls="nav-projects" aria-expanded="true">Projectes i sol·licituds</a>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="nav-sections" role="tabpanel" aria-labelledby="nav-sections-tab">
                            <div class="col-md-12 mt-3 mb-4">
                                <g:link controller="institutionSection" action="create" params="[institution: this.institution.id]" class="card-link btn btn-success pull-right"><i class="fa fa-plus" aria-hidden="true"></i> <g:message code="institutionSection.add.label"/></g:link>
                            </div>
                            <br/>
                            <table class="table table-sm table-striped" id="institutionSections">
                                <thead>
                                <tr>
                                    <th><g:message code="institutionSection.name.label" /></th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each var="section" in="${this.institution.sections}">
                                    <tr><td><g:link controller="institutionSection" action="show" id="${section.id.toString()}">${section}</g:link></td></tr>
                                </g:each>
                                </tbody>
                            </table>
                        </div>
                        <div class="tab-pane fade" id="nav-projects" role="tabpanel" aria-labelledby="nav-projects-tab">
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
                                            <tr><td><g:link controller="projectApplication" action="show" id="${projectApplication.id.toString()}">${projectApplication.name}</g:link></td></tr>
                                        </g:each>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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

<content tag="footScripts">
    <g:javascript>
        $(document).ready(function() {
            $('#institutionSections').DataTable({
                "language": {
                    "lengthMenu": "Mostra _MENU_ institucions per pàgina",
                    "zeroRecords": "No hi ha cap institució.",
                    "info": "Mostrant la pàgina _PAGE_ de _PAGES_",
                    "infoEmpty": "No s'ha trobat cap institució",
                    "infoFiltered": "(filtrades d'un total de _MAX_ institucions)",
                    "search": "Cercar",
                    "paginate": {
                        "next": "Següent",
                        "previous": "Anterior"
                    }
                }
            });

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
