<!DOCTYPE html>
<html lang="en">
<head>
    <title>BetxhaX</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <style>
    dl {
        width: 100%;
    }
    dd {
        border-bottom: 1px dashed #999;
        width: 100%;
    }
    p strong{
        font-size: 120%;
    }
    p strong.title{
        font-size: 100%;
    }
    p.text{
        font-size: 75%;
    }
    .keeptogether {
        page-break-inside:avoid;
    }
    </style>
</head>
<body style="font-size: 4em;">
<div class="row" style="text-align: center">
    <p><strong>Informe BETHAX de ${from} a ${to}</strong></p>
    <br/>
</div>

<div class="keeptogether">
    <p><strong class="title">1. Informació general</strong></p>
    <br />
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-6">
                    <p class="text">Fites creades: ${milestones?.size()}</p>
                </div>
                <div class="col-xs-6">
                    <p class="text">Fites tancades: ${closedMilestones?.size()}</p>
                </div>
                <div class="col-xs-6">
                    <p class="text">Sol·licituds creades: ${projectApplications?.size()}</p>
                </div>
                <div class="col-xs-6">
                    <p class="text">Sol·licituds tancades: ${closedProjectApplications?.size()}</p>
                </div>
                <div class="col-xs-6">
                    <p class="text">Projectes creats: ${projects?.size()}</p>
                </div>
                <div class="col-xs-6">
                    <p class="text">Peticions externes: ${serviceRequests?.size()}</p>
                </div>
            </div>
        </div>
    </div>

    <br/>
    <strong><p class="text">Procedència de les sol·licituds</p></strong>
    <div class="row">
        <div class="col-xs-4">
            <p class="text">Internes: ${internal}</p>
        </div>
        <div class="col-xs-4">
            <p class="text">Externes públiques: ${pubExternal}</p>
        </div>
        <div class="col-xs-4">
            <p class="text">Externes privades: ${privExternal}</p>
        </div>
    </div>
</div>

<br/><br/>
<div id="container" style="min-width: 310px; height: 400px;  display: none"></div>
<canvas id="canvas" width="6000" height="2000" style="display: none;"></canvas>
<div id="pwChartPlace"></div>

<div id="container2" style="min-width: 310px; height: 400px;  display: none"></div>
<canvas id="canvas2" width="6000" height="2000" style="display: none;"></canvas>
<div id="pwChartPlace2"></div>

<br/>
<div class="keeptogether">
    <p><strong class="title">2. Sol·licituds creades</strong></p>

    <g:each var="pA" in="${projectApplications}">
        <strong><p class="text">${pA.name} (Responsable: ${pA.headStatistician.givenName} ${pA.headStatistician.familyName})</p></strong>
        <p class="text">${pA.description}</p>
        <br/>
        <div class="row">
            <div class="col-xs-6">
                <p class="text">Tipus: <g:message code="enum.institutionType.value.${pA.applicationType}"/> </p>
            </div>
            <div class="col-xs-6">
                <p class="text">Sol·licitant: ${pA.applicant.name}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Sol·licitud associada: ${pA.linkedApplication?.name}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Plà de treball: <g:message code="default.yesno.${pA.isWorkPlanNeeded}"/> </p>
            </div>
            <div class="col-xs-6">
                <p class="text">Pressupost: ${pA.budget}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Projectes:
                    <g:each var="p" in="${pA.projects}">
                        ${p.name}
                    </g:each>
                </p>
            </div>
        </div>
        <br/>
    </g:each>
</div>

<div class="keeptogether">
    <p><strong class="title">3. Sol·licituds finalitzades</strong></p>
    <g:each var="pA" in="${closedProjectApplications}">
        <strong><p class="text">${pA.name} (Responsable: ${pA.headStatistician.givenName} ${pA.headStatistician.familyName})</p></strong>
        <p class="text">${pA.description}</p>
        <br/>
        <div class="row">
            <div class="col-xs-6">
                <p class="text">Tipus: <g:message code="enum.institutionType.value.${pA.applicationType}"/> </p>
            </div>
            <div class="col-xs-6">
                <p class="text">Sol·licitant: ${pA.applicant.name}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Sol·licitud associada: ${pA.linkedApplication?.name}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Plà de treball: <g:message code="default.yesno.${pA.isWorkPlanNeeded}"/> </p>
            </div>
            <div class="col-xs-6">
                <p class="text">Pressupost: ${pA.budget}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Projectes:
                <g:each var="p" in="${pA.projects}">
                    ${p.name}
                </g:each>
                </p>
            </div>
        </div>

        <br/>

        <div class="row">
            <div class="col-xs-6">
                <p class="text">Data tancament: <g:formatDate format="dd/MM/yyyy" date="${pA?.closingDate}"/> </p>
            </div>
            <div class="col-xs-6">
                <p class="text">Comentaris tancament: ${pA.closingComments}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Ordre de tancament:  <g:message code="default.yesno.${pA.isInvoiceIssued}"/></p>
            </div>
            <div class="col-xs-6">
                <p class="text">Import factura: ${pA.invoiceAmount}</p>
            </div>
            <div class="col-xs-6">
                <p class="text">Data de l'ordre de pagament: <g:formatDate format="dd/MM/yyyy" date="${pA?.invoiceDate}"/></p>
            </div>
            <div class="col-xs-6">
                <p class="text">Data ingrés import: <g:formatDate format="dd/MM/yyyy" date="${pA?.invoicePaymentDate}"/></p>
            </div>
        </div>
        <br/>
    </g:each>
</div>

<br/>
<div class="keeptogether">
    <p><strong class="title">4. Peticions externes</strong></p>
    <br/>
    <div class="row">
        <div class="col-xs-4">
            <p class="text">Pendents: ${pendingServiceRequests} </p>
        </div>
        <div class="col-xs-4">
            <p class="text">Aprovades: ${approvedServiceRequests} </p>
        </div>
        <div class="col-xs-4">
            <p class="text">Refusades: ${refusedServiceRequests} </p>
        </div>
    </div>

    <br/>

    <p class="text">
        <g:each var="sR" in="${serviceRequests}">
            <g:if test="${sR.isApproved == null}">
                - <b>${sR.researchProject} (${sR.name}):</b> Pendent
            </g:if>
            <g:if test="${sR.isApproved == false}">
                - <b>${sR.researchProject} (${sR.name}):</b> Refusada
            </g:if>
            <g:if test="${sR.isApproved == true}">
                - <b>${sR.researchProject} (${sR.name}):</b> Aprovada
            </g:if>
            <br/>
        </g:each>
    </p>
</div>

<script
        src="https://code.jquery.com/jquery-3.2.1.js"
        integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<!-- optional -->
<script src="https://code.highcharts.com/modules/offline-exporting.js"></script>
<script type="text/javascript" src="https://canvg.github.io/canvg/rgbcolor.js"></script>
<script type="text/javascript" src="https://canvg.github.io/canvg/StackBlur.js"></script>
<script type="text/javascript" src="https://canvg.github.io/canvg/canvg.js"></script>

<script>
    var months = [];
    <g:each var="m" in="${monthString}">
        months.push("${m}");
    </g:each>
    var created = [];
    <g:each var="m" in="${createdMilestonesPerMonth}">
        created.push(${m});
    </g:each>
    var finished = [];
    <g:each var="m" in="${closedMilestonesPerMonth}">
        finished.push(${m});
    </g:each>

    var chart = Highcharts.chart('container', {
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
      }
    });

    chart.tooltip.refresh(chart.series[0].points[0]);
    canvg(document.getElementById('canvas'), chart.getSVG());

    var canvas = document.getElementById("canvas");
    var img = canvas.toDataURL("image/png");

    $('#pwChartPlace').html('<img width="100%" src="'+img+'"/>');
</script>
<script>
    var users = [];
    <g:each var="u" in="${users}">
        users.push("${u}");
    </g:each>

    var openMilestonesUser = [];
    <g:each var="u" in="${openMilestonesUser}">
        openMilestonesUser.push(${u});
    </g:each>

    var costOpenMilestonesUser = [];
    <g:each var="u" in="${costOpenMilestonesUser}">
        costOpenMilestonesUser.push(${u});
    </g:each>

    var closedMilestonesUser = [];
    <g:each var="u" in="${closedMilestonesUser}">
        closedMilestonesUser.push(${u});
    </g:each>

    var costClosedMilestonesUser = [];
    <g:each var="u" in="${costClosedMilestonesUser}">
        costClosedMilestonesUser.push(${u});
    </g:each>

    var chart2 = Highcharts.chart('container2', {
        chart: {
            type: 'column'
        },
        title: {
            text: 'Fites per persona'
        },
        xAxis: {
            categories: users
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Creades',
            data: openMilestonesUser
        }, {
            name: 'Cost estimat fites creades',
            data: costOpenMilestonesUser
        }, {
            name: 'Tancades',
            data: closedMilestonesUser
        }, {
            name: 'Cost estimat fites tancades',
            data: costClosedMilestonesUser
        }]
    });
    canvg(document.getElementById('canvas2'), chart2.getSVG());

    var canvas2 = document.getElementById("canvas2");
    var img2 = canvas2.toDataURL("image/png");
    $('#pwChartPlace2').html('<img width="100%" src="'+img2+'"/>');
</script>

</body>
</html>