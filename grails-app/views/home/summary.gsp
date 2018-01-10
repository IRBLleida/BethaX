<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title>BethaX</title>
    <style>
    .col-md-12 .pull-right{
        margin-top: 10px;
        margin-bottom: 20px;
    }
    </style>
</head>
<body>
<div class="row" style="text-align: center;">
    <div class="col-md-12" style="height: 50px; margin-bottom: 20px;">
        <g:link controller="report" action="options" class="btn btn-outline-info pull-right">
            <i class="fa fa-file-pdf-o" aria-hidden="true"></i>
            Generar informe
        </g:link>
    </div>

    <div class="col-md-2"></div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">${pendingMilestones}</h2>
            <p class="card-text">Fites pendents</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">${finishedMilestones}</h2>
            <p class="card-text">Fites finalitzades</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">${projectApplications}</h2>
            <p class="card-text">Sol·licituds</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">${projects}</h2>
            <p class="card-text">Projectes</p>
        </div>
    </div>
</div>

<div class="row mt-2">
    <div class="col-md-6">
        <div class="card">
            <div id="container" style="min-width: 310px; height: 400px;"></div>
        </div>
    </div>

    <div class="col-md-6 ml-md-auto">
        <div class="card">
            <div id="container2" style="min-width: 310px; height: 400px;"></div>
        </div>
    </div>
</div>
<div class="row mt-4">
    <div class="col-md-4">
        <div class="card">
            <div id="container3"></div>
        </div>
    </div>

    <div class="col-md-7 ml-3">
        <div style="text-align: center">
            <span style="color:#333333;font-size:18px;fill:#333333;margin-bottom: 10px">Institucions amb major nombre de sol·licituds</span>
        </div>
        <nav class="nav nav-tabs mt-4" id="myTab" role="tablist">
            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-expanded="true">Internes</a>
            <div class="dropdown">
                <a class="nav-item nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    Externes
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" id="nav-dropdown1-tab" href="#nav-dropdown1" role="tab" data-toggle="tab" aria-controls="nav-dropdown1">Públiques</a>
                    <a class="dropdown-item" id="nav-dropdown2-tab" href="#nav-dropdown2" role="tab" data-toggle="tab" aria-controls="nav-dropdown2">Privades</a>
                </div>
            </div>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><g:render template="table" model="[id:1]"/> </div>
            <div class="tab-pane fade" id="nav-dropdown1" role="tabpanel" aria-labelledby="nav-dropdown1-tab"><g:render template="table" model="[id:2]"/></div>
            <div class="tab-pane fade" id="nav-dropdown2" role="tabpanel" aria-labelledby="nav-dropdown2-tab"><g:render template="table" model="[id:3]"/></div>
        </div>
    </div>
</div>

<content tag="footScripts">
    <g:javascript>
        var data = [];
        <g:each var="user" in="${usersMap}">
            data.push({'name' : "${user?.key}", 'y': ${user?.value}});
        </g:each>

        var cost = []
        <g:each var="user" in="${usersEstimatedCost}">
            cost.push({'name' : "${user?.key}", 'y': ${user?.value}});
        </g:each>

        // Create the chart
        Highcharts.chart('container', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Fites obertes'
            },
            xAxis: {
                type: 'category'
            },
            yAxis: {
                title: {
                    text: 'Fites i cost'
                }
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                        format: '{point.y}'
                    }
                }
            },
            series: [{
                name: 'Fites',
                data: data
            }, {
                name: 'Cost',
                data: cost
            }],
            credits: {
                enabled: false
            }
        });
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

    <g:javascript>
        Highcharts.chart('container3', {

            title: {
                text: 'Procedència de les sol·licituds'
            },
            series: [{
                type: 'pie',
                allowPointSelect: true,
                keys: ['name', 'y', 'selected', 'sliced'],
                data: [
                    ['Internes', ${internal}, false],
                    ['Externes públiques', ${externalPub}, false],
                    ['Externes privades', ${externalPriv}, false]
                ],
                showInLegend: true
            }],
            credits: {
                enabled: false
            },
        });
    </g:javascript>
</content>
</body>