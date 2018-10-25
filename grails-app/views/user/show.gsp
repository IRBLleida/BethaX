<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div id="show-user" class="content scaffold-show" role="main">
    <g:if test="${flash.message}">
        <div class="alert alert-info" role="alert">
            ${flash.message}
        </div>
    </g:if>
    <div class="col-md-12" style="margin-top: 10px;">
        <div class="card card-01">
            <div class="row">
                <div class="col-md-3">
                    <div class="profile-box" style="padding: 10px;">
                        <img class="card-img-top rounded-circle" src="${createLink(controller: 'user', action: 'photo', id: this.user.id.toString())}"  style="width:120px;height:120px;"/>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="card-body">
                        <h4 class="card-title">
                            ${user.givenName} ${user.familyName}
                            <g:if test="${isHimself}">
                                <g:link class="edit" action="edit" resource="${this.user}"><i class="fa fa-pencil" aria-hidden="true" style="    font-size: 1rem;"></i></g:link>
                            </g:if>
                        </h4>
                        <g:if test="${!user.position && !user.website && !user.biography}">
                            <div class="row">
                                <div class="col-md-9">
                                    <p class="lead">Sense informació de perfil</p>
                                    <p class="card-text">Caram, quin perfil més desolat. Està tant buit que en Keanu Reeves està trist.</p>
                                    <g:if test="${isHimself}">
                                        <p class="card-text">Anima'l <g:link controller="user" action="edit">afegint la teva informació <i class="material-icons">tag_faces</i></g:link></p>
                                    </g:if>
                                </div>
                                <div class="col-md-3">
                                    <img src="https://files.gamebanana.com/img/ico/sprays/52ecd3c23c1b5.png" width="100%" />
                                </div>
                            </div>
                        </g:if>
                        <g:if test="${user.position}">
                            <p class="card-text">
                                <i class="material-icons">card_membership</i> ${user.position}
                            </p>
                        </g:if>
                        <g:if test="${user.website}">
                            <p class="card-text">
                                <i class="material-icons">web</i> <a href="${user.website}" target="_blank">${user.website}</a>
                            </p>
                        </g:if>
                        <g:if test="${user.biography}">
                            <p class="card-text">
                                <i class="material-icons">face</i> ${user.biography}
                            </p>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6" style="margin-top: 30px;">
            <div class="card">
                <div class="card-body crud">
                    <h4 class="card-title"><g:message code="profile.milestones.label" /></h4>
                    <hr class="brace">
                    <g:if test="${milestoneList?.size() > 0}">
                        <table class="table table-sm table-striped" id="pendingMilestones">
                            <thead>
                            <tr>
                                <th><g:message code="milestone.name.label"/></th>
                                <th><g:message code="milestone.deadline.label"/></th>
                                <th><g:message code="milestone.workPlan.label"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each var="milestone" in="${milestoneList}">
                                <tr>
                                <th scope="row">
                                    <g:link controller="workPlan" action="show" id="${milestone.workPlan.id.toString()}">
                                        ${milestone.name}
                                    </g:link>
                                </th>
                                    <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                                    <td>${milestone.workPlan}</td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </g:if>
                    <g:else>
                        <g:if test="${isHimself}">
                            <div class="jumbotron">
                                <h1 class="display-3">
                                    <asset:image src="open-box.png" />
                                    Que bé!
                                </h1>
                                <p class="lead">Enhorabona, no hi ha cap ${message(code: "milestone.label")?.toLowerCase()}!</p>
                                <hr class="my-4">
                                <p>Pots afegir-ne fent clic al botó de sota.</p>
                                <p class="lead">
                                    <g:link controller="milestone" action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'milestone.label')?.toLowerCase()]" /></g:link>
                                </p>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="jumbotron">
                                <h1 class="display-3">
                                    <img src="http://img.allw.mn/content/ct/xs/wlzjk4yb56835260120e5191666070.gif" class="rounded-circle" width="128" height="128" />
                                    Cap ni una
                                </h1>
                                <p class="lead">Sembla que ${user.givenName} no té res a fer.</p>
                                <hr class="my-4">
                                <p class="text-muted">(<i class="fa fa-bath" aria-hidden="true"></i> N'hi ha que viuen bé)</p>
                            </div>
                        </g:else>
                    </g:else>
                </div>
            </div>
        </div>
        <div class="col-md-6" style="margin-top: 30px;">
            <div class="card">
                <div id="container2" style="min-width: 310px; height: 400px;"></div>
            </div>
        </div>

        <div class="col-md-12 mt-4">
            <div class="card">
                <div class="card-body crud">
                    <h4 class="card-title">Sol·licituds</h4>
                    <hr class="brace">
                    <table class="table table-sm table-striped" id="projectApplicationsTable">
                        <thead>
                        <tr>
                            <th><g:message code="projectApplication.entryDate.label"/></th>
                            <th>Data d'entrega més propera</th>
                            <th><g:message code="projectApplication.name.label"/></th>
                            <th><g:message code="projectApplication.applicant.label"/></th>
                            <th><g:message code="projectApplication.status.label"/></th>
                            <th><g:message code="projectApplication.projects.label"/></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="projectApplication" in="${projectApplicationList}">
                            <tr>
                                <th scope="row">
                                    <g:link controller="projectApplication" action="show" id="${projectApplication.id.toString()}">
                                        <g:formatDate date="${projectApplication.entryDate}" format="dd/MM/yyyy" />
                                    </g:link>
                                </th>
                                <td>
                                    <g:formatDate date="${projectApplication?.workPlan?.closestMilestone?.deadline}" format="dd/MM/yyyy" />
                                </td>
                                <td>${projectApplication.name}</td>
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
                </div>
            </div>
        </div>
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
            $('#pendingMilestones').DataTable({
                "language": {
                    "lengthMenu": "Mostra _MENU_ fites per pàgina",
                    "zeroRecords": "No hi ha cap fita.",
                    "info": "Mostrant la pàgina _PAGE_ de _PAGES_",
                    "infoEmpty": "No s'ha trobat cap fita",
                    "infoFiltered": "(filtrades d'un total de _MAX_ fites)",
                    "search": "Cercar",
                    "paginate": {
                        "next": "Següent",
                        "previous": "Anterior"
                    }
                },
                "columnDefs": [
                    { type: 'date-eu', targets: 1 }
                ]
            });

            $('#projectApplicationsTable').DataTable({
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
                    { type: 'date-eu', targets: 0 }
                ]
            });
        } );
    </g:javascript>

    <g:javascript>
    var months = []
    <g:each var="m" in="${monthString}">
        months.push("${m}");
    </g:each>
        var created = []
        <g:each var="m" in="${createdMilestones}">
            created.push(${m});
        </g:each>
        var finished = []
        <g:each var="m" in="${closedMilestones}">
            finished.push(${m});
        </g:each>

        Highcharts.chart('container2', {
            chart: {
                type: 'line'
            },
            title: {
                text: 'Relació fites afegides i finalitzades'
            },
            xAxis: {
                categories: months
            },
            yAxis: {
                title: {
                    text: 'Quantitat'
                }
            },
            series: [{
                name: 'Creades',
                data: created
            }, {
                name: 'Finalitzades',
                data: finished
            }],
            credits: {
              enabled: false
          },
        });
    </g:javascript>
</content>
</body>
</html>
