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
<div class="card-body crud">
    <h4 class="card-title">Opcions de l'informe</h4>
    <hr class="brace">

    <g:form controller="report" action="generateReport" target="_blank" class="form">
        <div class="row justify-content-md-center">
            <div class="col-md-3">
                Des de
                <div class="input-group date">
                    <input type="text" name="from" value="" class="form-control" id="from" placeholder="dd/mm/aaaa" required="required"/>
                    <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                </div>
            </div>

            <div class="col-md-3">
                Fins a
                <div class="input-group date">
                    <input type="text" name="to" value="" class="form-control" id="to" placeholder="dd/mm/aaaa" required="required"/>
                    <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                </div>
            </div>
        </div>
        <br/>
        <div class="row justify-content-md-center" style="margin-top: 10px;">
            <div class="col-md-1">
                <g:submitButton id="generate" name="create" value="Generar" class="btn btn-info"/>
            </div>
        </div>
    </g:form>

</div>
</body>
</html>