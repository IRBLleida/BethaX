<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<h2><g:message code="default.list.label" args="[entityName]" /></h2>

<table class="table">
    <thead class="thead-inverse">
    <tr>
        <th>#</th>
        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${milestoneList?.size() > 0}">
        <div class="col-md-12" style="height: 50px;">
            <g:link controller="milestone" action="create" class="btn btn-outline-success pull-right">
                <i class="fa fa-plus-circle" aria-hidden="true"></i>
                Fita nova
            </g:link>
        </div>
        <nav class="nav nav-tabs" id="myTab" role="tablist">
            <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-expanded="true">En curs</a>
            <a class="nav-item nav-link active" id="nav-home-tab2" data-toggle="tab" href="#nav-home2" role="tab" aria-controls="nav-home" aria-expanded="true">Finalitzades</a>
        </nav>
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><g:render template="table" model="[id:1]"/> </div>
            <div class="tab-pane fade show active" id="nav-home2" role="tabpanel" aria-labelledby="nav-home-tab2"><g:render template="table" model="[id:0]"/> </div>
        </div>
    </g:if>
    <g:else>
        <div class="jumbotron">
            <h1 class="display-3">
                <asset:image src="open-box.png" />
                Ups ...
            </h1>
            <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "milestone.label")?.toLowerCase()}!</p>
            <hr class="my-4">
            <p>Pots afegir-ne fent clic al botó de sota.</p>
            <p class="lead">
                <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'milestone.label')]" /></g:link>
            </p>
        </div>
    </g:else>
    </tbody>
</table>
</body>
</html>
