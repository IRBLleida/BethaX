<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">Les meves sol·licituds</h4>
        <hr class="brace">


        <g:if test="${projectApplicationList?.size() > 0}">
            <table class="table table-sm table-striped" id="myProjectApplications">
                <thead >
                <tr>
                    <th><g:message code="projectApplication.name.label"/></th>
                    <th><g:message code="projectApplication.entryDate.label"/></th>
                    <th>Data d'entrega més propera</th>
                    <th>Temps estimat de les fites pendents</th>
                    <th><g:message code="projectApplication.applicant.label"/></th>
                    <th><g:message code="projectApplication.status.label"/></th>
                    <th><g:message code="projectApplication.projects.label"/></th>
                </tr>
                </thead>
                <tbody>
                    <g:each var="projectApplication" in="${projectApplicationList}">
                        <tr>
                            <td><g:link action="show" id="${projectApplication.id.toString()}"><b>${projectApplication.name}</b></g:link></td>
                            <td><g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" /></td>
                            <td><g:formatDate date="${projectApplication?.workPlan?.closestMilestone?.deadline}" format="dd/MM/yyyy" /></td>
                            <td>${projectApplication?.workPlan?.milestonesEstimatedTime}</td>
                            <td>${projectApplication.applicant}</td>
                            <td>
                                <g:if test="${projectApplication.closingDate}">
                                    <i class="fa fa-file-archive-o" aria-hidden="true"></i> Tancada
                                </g:if>
                                <g:else>
                                    <i class="fa fa-folder-open-o" aria-hidden="true"></i> Oberta
                                </g:else>
                            </td>
                            <td>
                                <g:each var="project" in="${projectApplication.projects}">
                                    <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                                </g:each>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </g:if>
        <g:else>
            <div class="jumbotron">
                <h1 class="display-3">
                    <asset:image src="open-box.png" />
                    Ups ...
                </h1>
                <p class="lead">Casum l'òs pedrer, encara no ets responsable de cap sol·licitud!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'projectApplication.label')?.toLowerCase()]" /></g:link>
                </p>
            </div>
        </g:else>
        <g:if test="${projectApplicationOthers?.size() > 0}">
            <hr />
            <h4 class="card-title">Altres sol·licituds</h4>
            <hr class="brace">
            <table class="table table-sm table-striped" id="otherProjectApplications">
                <thead>
                <tr>
                    <th><g:message code="projectApplication.name.label"/></th>
                    <th><g:message code="projectApplication.entryDate.label"/></th>
                    <th>Data d'entrega més propera</th>
                    <th>Temps estimat de les fites pendents</th>
                    <th><g:message code="projectApplication.applicant.label"/></th>
                    <th><g:message code="projectApplication.headStatistician.label"/></th>
                    <th><g:message code="projectApplication.status.label"/></th>
                    <th><g:message code="projectApplication.projects.label"/></th>
                </tr>
                </thead>
                <tbody>
                <g:each var="projectApplication" in="${projectApplicationOthers}">
                    <tr>
                        <td><g:link action="show" id="${projectApplication.id.toString()}"><b>${projectApplication.name}</b></g:link></td>
                        <td><g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" /></td>
                        <td><g:formatDate date="${projectApplication?.workPlan?.closestMilestone?.deadline}" format="dd/MM/yyyy" /></td>
                        <td>${projectApplication.applicant}</td>
                        <td><g:link controller="user" action="show" id="${projectApplication.headStatistician?.id?.toString()}">${projectApplication.headStatistician}</g:link></td>
                        <td>
                            <g:if test="${projectApplication.closingDate}">
                                <i class="fa fa-file-archive-o" aria-hidden="true"></i> Tancada
                            </g:if>
                            <g:else>
                                <i class="fa fa-folder-open-o" aria-hidden="true"></i> Oberta
                            </g:else>
                        </td>
                        <td>
                            <g:each var="project" in="${projectApplication.projects}">
                                <g:link controller="project" action="show" id="${project.id.toString()}">${project}</g:link>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </g:if>
    </div>
</div>

<content tag="footScripts">
    <g:javascript>
        //Jquery Datatable date sorting pluggin
        jQuery.extend( jQuery.fn.dataTableExt.oSort, {
            "date-eu-pre": function ( date ) {
                date = date.replace(" ", "");

                if ( ! date ) {
                    return 0;
                }

                var year;
                var eu_date = date.split(/[\.\-\/]/);

                /*year (optional)*/
                if ( eu_date[2] ) {
                    year = eu_date[2];
                }
                else {
                    year = 0;
                }

                /*month*/
                var month = eu_date[1];
                if ( month.length == 1 ) {
                    month = 0+month;
                }

                /*day*/
                var day = eu_date[0];
                if ( day.length == 1 ) {
                    day = 0+day;
                }

                return (year + month + day) * 1;
            },

            "date-eu-asc": function ( a, b ) {
                return ((a < b) ? -1 : ((a > b) ? 1 : 0));
            },

            "date-eu-desc": function ( a, b ) {
                return ((a < b) ? 1 : ((a > b) ? -1 : 0));
            }
        } );

        $(document).ready(function() {
            $('#myProjectApplications').DataTable({
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
                },
                "columnDefs": [
                    { type: 'date-eu', targets: 1 },
                    { type: 'date-eu', targets: 2 }
                ]
            });

            $('#otherProjectApplications').DataTable({
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
                },
                "columnDefs": [
                    { type: 'date-eu', targets: 1 },
                    { type: 'date-eu', targets: 2 }
                ]
            });
        } );
    </g:javascript>
</content>
</body>
</html>
