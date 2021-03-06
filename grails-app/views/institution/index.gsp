<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <style>
        .col-md-12 .pull-right{
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <div class="col-md-12" style="height: 50px;">
        <g:link controller="institution" action="create" class="btn btn-outline-success pull-right">
            <i class="fa fa-plus-circle" aria-hidden="true"></i>
            Institució nova
        </g:link>
    </div>

    <nav class="nav nav-tabs" id="myTab" role="tablist">
        <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-expanded="true">Internes</a>
        <a class="nav-item nav-link" id="nav-dropdown1-tab" data-toggle="tab" href="#nav-dropdown1" role="tab" aria-controls="nav-dropdown1" aria-expanded="true">Externes públiques</a>
        <a class="nav-item nav-link" id="nav-dropdown2-tab" data-toggle="tab" href="#nav-dropdown2" role="tab" aria-controls="nav-dropdown2" aria-expanded="true">Externes privades</a>
    </nav>
    <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><g:render template="table" model="[id:1]"/> </div>
        <div class="tab-pane fade" id="nav-dropdown1" role="tabpanel" aria-labelledby="nav-dropdown1-tab"><g:render template="table" model="[id:2]"/></div>
        <div class="tab-pane fade" id="nav-dropdown2" role="tabpanel" aria-labelledby="nav-dropdown2-tab"><g:render template="table" model="[id:3]"/></div>
    </div>
</body>
</html>