<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">Llista de sol·licituds</h4>
        <hr class="brace">
        <g:if test="${projectApplicationList?.size() > 0}">
            <table class="table">
                <thead class="thead-inverse">
                <tr>
                    <th>#</th>
                    <th><g:message code="projectApplication.name.label" /></th>
                    <th><g:message code="projectApplication.applicant.label" /></th>
                    <th><g:message code="projectApplication.projects.label" /></th>
                </tr>
                </thead>
                <tbody>
                    <g:each var="projectApplication" in="${projectApplicationList}">
                        <tr>
                        <th scope="row">
                            <g:link action="show" id="${projectApplication.id.toString()}">
                                ${projectApplication.id.toString().take(5)}...</th>
                            </g:link>
                            <td>${projectApplication.name}</td>
                            <td>${projectApplication.applicant}</td>
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
                <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "projectApplication.label")?.toLowerCase()}!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" /></g:link>
                </p>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>





<%--
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'projectApplication.label', default: 'ProjectApplication')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
        .col-md-12 .pull-right{
            margin-top: 10px;
        }
        </style>
    </head>
<body>

<div class="col-md-12" style="height: 50px;">
    <g:link controller="projectApplication" action="create" class="btn btn-outline-success pull-right">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>
        Sol·licitud nova
    </g:link>
</div>

<nav class="nav nav-tabs" id="myTab" role="tablist">
    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-expanded="true">Actuals</a>
    <a class="nav-item nav-link" id="nav-home-tab2" data-toggle="tab" href="#nav-home2" role="tab" aria-controls="nav-home" aria-expanded="true">En espera</a>
    <a class="nav-item nav-link" id="nav-home-tab3" data-toggle="tab" href="#nav-home3" role="tab" aria-controls="nav-home" aria-expanded="true">Finalitzades</a>

</nav>
<div class="tab-content" id="nav-tabContent">
    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><g:render template="table" model="[id:2]"/> </div>
    <div class="tab-pane fade" id="nav-home2" role="tabpanel" aria-labelledby="nav-home-tab2"><g:render template="table" model="[id:1]"/></div>
    <div class="tab-pane fade" id="nav-home3" role="tabpanel" aria-labelledby="nav-home-tab3"><g:render template="table" model="[id:3]"/></div>
</div>
</body>
</html>
--%>