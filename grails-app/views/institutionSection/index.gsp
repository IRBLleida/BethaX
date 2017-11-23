<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
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
    <g:if test="${institutionSectionList?.size() > 0}">
        <g:each var="institutionSection" in="${institutionSectionList}">
            <tr>
                <th scope="row">
                    <g:link action="show" id="${institutionSection.id.toString()}">
                        ${institutionSection.id.toString().take(5)}</th>
                    </g:link>
                <td></td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <div class="jumbotron">
            <h1 class="display-3">
                <asset:image src="open-box.png" />
                Ups ...
            </h1>
            <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "institutionSection.label")?.toLowerCase()}!</p>
            <hr class="my-4">
            <p>Pots afegir-ne fent clic al botó de sota.</p>
            <p class="lead">
                <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" /></g:link>
            </p>
        </div>
    </g:else>
    </tbody>
</table>
</body>
</html>
