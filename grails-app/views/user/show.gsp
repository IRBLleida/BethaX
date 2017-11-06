<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <asset:stylesheet src="profile.css" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="show-user" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>

            <div class="col-md-12">
                <div class="card card-01">
                    <div class="profile-box">
                        <img class="card-img-top rounded-circle" src="${resource(dir: 'images', file: 'user.png')}"  style="width:120px;height:120px;"/>
                    </div>
                    <div class="card-body text-center">
                        <h4 class="card-title">
                            <sec:loggedInUserInfo field="givenName" /> <sec:loggedInUserInfo field="familyName" />
                            <g:link class="edit" action="edit" resource="${this.user}"><i class="fa fa-pencil" aria-hidden="true" style="    font-size: 1rem;"></i></g:link>
                        </h4>
                        <p class="card-text">
                            <g:if test="${user.biography}">
                                ${user.biography}
                            </g:if><g:else>
                                <g:link class="edit" action="edit" resource="${this.user}">
                                    <i class="fa fa-plus" aria-hidden="true"></i>
                                    Afegir biografia
                                </g:link>
                            </g:else>
                            <g:if test="${user.website}"><br/><a href="${user?.website}">(${user?.website})</a></g:if>
                        </p>
                    </div>
                </div>

            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body crud">
                            <h4 class="card-title"><g:message code="profile.milestones.label" /></h4>
                            <hr class="brace">
                            <g:if test="${milestoneList?.size() > 0}">
                                <table class="table">
                                    <thead class="thead-inverse">
                                    <tr>
                                        <th><g:message code="milestone.name.label" /></th>
                                        <th><g:message code="milestone.deadline.label" /></th>
                                        <th><g:message code="milestone.workPlan.label" /></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each var="milestone" in="${milestoneList}">
                                        <tr>
                                        <th scope="row">
                                            <g:link controller="milestone" action="show" id="${milestone.id.toString()}">
                                                ${milestone.name}</th>
                                            </g:link>
                                            <td><g:formatDate date="${milestone.deadline}" format="dd/MM/yyyy" /></td>
                                            <td>${milestone.workPlan}</td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                            </g:if>
                            <g:else>
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
                            </g:else>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card">
                        <div id="container2" style="min-width: 310px; height: 400px;"></div>
                    </div>
                </div>
            </div>
        </div>
    <content tag="footScripts">
        <g:javascript>
            Highcharts.chart('container2', {
                chart: {
                    type: 'line'
                },
                title: {
                    text: 'Relació fites afegides i finalitzades'
                },
                xAxis: {
                    categories: ['Gen', 'Feb', 'Mar', 'Abr', 'Maig', 'Jun', 'Jul', 'Ago', 'Set', 'Oct', 'Nov', 'Des']
                },
                yAxis: {
                    title: {
                        text: 'Quantitat'
                    }
                },
                series: [{
                    name: 'Finalitzades',
                    data: [3, 4, 5, 12, 8, 3, 24, 6, 8, 12, 3, 22]
                }, {
                    name: 'Creades',
                    data: [5, 9, 12 , 3, 7, 13, 5, 7, 10, 12, 6, 9]
                }],
                credits: {
                    enabled: false
                },
            });
        </g:javascript>
    </content>
    </body>
</html>
