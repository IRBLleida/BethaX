<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'institution.label', default: 'Institution')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-institution" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <div class="panel-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Institució</th>
                        <th>Acció</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each var="institution" in="${institutionList}">
                        <tr>
                            <td>
                                <g:link action="show" id="${institution.id.toString()}">
                                    ${institution.name}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="institution" action="edit" id="${institution?.id}" params="[institution: institution?.id]" class="btn btn-warning">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </g:link>
                                <g:link controller="blooinstitutiondTest" action="delete" id="${institution?.id}" class="btn btn-danger delete">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <f:table collection="${institutionList}" />

            <div class="pagination">
                <g:paginate total="${institutionCount ?: 0}" />
            </div>
        </div>
    </body>
</html>