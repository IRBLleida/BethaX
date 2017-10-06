<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style>
    .col-md-12 .pull-right{
        margin-top: 10px;
        margin-bottom: 20px;
    }
    </style>
</head>
<body>
<div class="row" style="text-align: center; margin-top: 20px">
    <div class="col-md-2"></div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">5</h2>
            <p class="card-text">Fites pendents</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">133</h2>
            <p class="card-text">Fites finalitzades</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">98</h2>
            <p class="card-text">Sol·licituds</p>
        </div>
    </div>
    <div class="card border-info mb-3 col-md-2" style="max-width: 20rem; margin-left: 15px">
        <div class="card-body text-info">
            <h2 class="card-title">15</h2>
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
        // Create the chart
        Highcharts.chart('container', {
            chart: {
                type: 'column'
            },
            title: {
                text: 'Fites obertes'
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                type: 'category'
            },
            yAxis: {
                title: {
                    text: 'Percentatge'
                }

            },
            legend: {
                enabled: false
            },
            plotOptions: {
                series: {
                    borderWidth: 0,
                    dataLabels: {
                        enabled: true,
                        format: '{point.y:.1f}%'
                    }
                }
            },

            tooltip: {
                headerFormat: '',
                pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> del total ({point.n})<br/>'
            },

            series: [{
                name: 'Brands',
                colorByPoint: true,
                data: [{
                    name: 'Pau Balaguer',
                    y: 9.33,
                    n: 5,
                }, {
                    name: 'Jordi Vilaplana',
                    y: 24.03,
                    n: 4,
                }, {
                    name: 'Montse Rué',
                    y: 15.38,
                    n: 6,
                }, {
                    name: 'Hèctor Perpiñán',
                    y: 4.77,
                    n: 8,
                }, {
                    name: 'Carles Forné',
                    y: 7.91,
                    n: 8,
                }]
            }],
            credits: {
                enabled: false
            }
        });
    </g:javascript>

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
                    ['Internes', 126.0, false],
                    ['Externes públiques', 135.6, false],
                    ['Externes privades', 148.5, false]
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