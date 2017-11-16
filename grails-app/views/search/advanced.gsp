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
        <h4 class="card-title">Cerca avançada</h4>
        <hr class="brace">

        <div id="advancedSearch">
            <div class="row justify-content-md-center">
                <div class="col-md-10">
                    Que contingui ...
                    <div class="input-group">
                        <input type="text" name="text" value="" class="form-control" id="text" placeholder="dd/mm/aaaa"/>
                        <span class="input-group-addon"><i class="fa fa-font" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    Data de creació mínima
                    <div class="input-group date">
                        <input type="text" name="from" value="" class="form-control" id="from" placeholder="dd/mm/aaaa"/>
                        <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                    </div>
                </div>

                <div class="col-md-5">
                    Data de creació màxima
                    <div class="input-group date">
                        <input type="text" name="to" value="" class="form-control" id="to" placeholder="dd/mm/aaaa"/>
                        <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    Data de finalitzció màxima
                    <div class="input-group date">
                        <input type="text" name="closingFrom" value="" class="form-control" id="closingFrom" placeholder="dd/mm/aaaa"/>
                        <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                    </div>
                </div>

                <div class="col-md-5">
                    Data de finalització màxima
                    <div class="input-group date">
                        <input type="text" name="closingTo" value="" class="form-control" id="closingTo" placeholder="dd/mm/aaaa"/>
                        <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    Fites amb cost estimat menor o igual de
                    <div class="input-group">
                        <input type="number" min="0" name="estimatedLower" value="" class="form-control" id="estimatedLower" placeholder="Número"/>
                        <span class="input-group-addon"><i class="fa fa-sort-numeric-desc" aria-hidden="true"></i></span>
                    </div>
                </div>
                <div class="col-md-5">
                    Fites amb cost estimat major de
                    <div class="input-group">
                        <input type="number" min="0" name="estimatedGreater" value="" class="form-control" id="estimatedGreater" placeholder="Número"/>
                        <span class="input-group-addon"><i class="fa fa-sort-numeric-asc" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    Sol·licituds amb nombre de fites menor o igual de
                    <div class="input-group">
                        <input type="number" min="0" name="milestononesLower" value="" class="form-control" id="milestononesLower" placeholder="Número"/>
                        <span class="input-group-addon"><i class="fa fa-sort-numeric-desc" aria-hidden="true"></i></span>
                    </div>
                </div>
                <div class="col-md-5">
                    Sol·licituds amb nombre de fites major de
                    <div class="input-group">
                        <input type="number" min="0" name="milestononesGreater" value="" class="form-control" id="milestononesGreater" placeholder="Número"/>
                        <span class="input-group-addon"><i class="fa fa-sort-numeric-asc" aria-hidden="true"></i></span>
                    </div>
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    <g:checkBox name="finished" id="finished" value="${false}" />
                    Solament les finalitzades
                </div>
                <div class="col-md-5">
                    <g:checkBox name="notPayed" id="notPayed" value="${false}" />
                    Solament les no cobrades
                </div>
            </div>
            <br/>
            <div class="row justify-content-md-center">
                <div class="col-md-5">
                    <g:checkBox name="fromRequest" id="fromRequest" value="${false}" />
                    Solament sol·licituds procedents d'una petició
                </div>
                <div class="col-md-5">
                    <g:checkBox name="notFromRequest" id="notFromRequest" value="${false}" />
                    Solament sol·licituds sense petició associada
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>