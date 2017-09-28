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
    <a class="nav-item nav-link" id="nav-home-tab2" data-toggle="tab" href="#nav-home2" role="tab" aria-controls="nav-home" aria-expanded="true">No iniciades</a>
    <a class="nav-item nav-link" id="nav-home-tab3" data-toggle="tab" href="#nav-home3" role="tab" aria-controls="nav-home" aria-expanded="true">En espera</a>

</nav>
<div class="tab-content" id="nav-tabContent">
    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><g:render template="table" model="[id:2]"/> </div>
    <div class="tab-pane fade" id="nav-home2" role="tabpanel" aria-labelledby="nav-home-tab2"><g:render template="table" model="[id:1]"/></div>
    <div class="tab-pane fade" id="nav-home3" role="tabpanel" aria-labelledby="nav-home-tab3"><g:render template="table" model="[id:3]"/></div>
</div>
</body>
</html>