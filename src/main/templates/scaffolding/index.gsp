<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="\${message(code: '${propertyName}.label', default: '${className}')}" />
</head>
<body>
<g:if test="\${flash.message}">
    <div class="message" role="status">\${flash.message}</div>
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
    <g:if test="\${${propertyName}List.size() > 0}">
        <g:each var="${propertyName}" in="\${${propertyName}List}">
            <tr>
                <th scope="row">
                    <g:link action="show" id="\${${propertyName}.id.toString()}">
                        \${${propertyName}.id.toString().take(5)}</th>
                    </g:link>
                <td></td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <div class="jumbotron">
            <h2 class="display-3">Casum l'òs pedrer, encara no hi ha cap <g:message code="${propertyName}.label" />!</h2>
            <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
            <hr class="my-4">
            <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
            <p class="lead">
                <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
            </p>
        </div>
    </g:else>
    </tbody>
</table>
</body>
</html>
