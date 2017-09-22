<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <style>
            .col-md-12 .pull-right{
                margin-top: 10px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
    <div class="col-md-12" style="height: 50px;">
        <g:link controller="person" action="create" class="btn btn-outline-success pull-right">
            <i class="fa fa-plus-circle" aria-hidden="true"></i>
            Persona nova
        </g:link>
    </div>

    <div id="list-person" class="content scaffold-list" role="main">
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <div class="panel-body">
            <table class="table">
                <thead>
                <tr>
                    <th>Persona</th>
                    <th>Acció</th>
                </tr>
                </thead>
                <tbody>
                <g:each var="person" in="${personList}">
                    <tr>
                        <td>
                            <g:link action="show" id="${person.id.toString()}">
                                ${person.name}
                            </g:link>
                        </td>
                        <td>
                            <g:link controller="person" action="edit" id="${person?.id}" params="[person: person?.id]" class="btn btn-warning">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            </g:link>
                            <g:link controller="person" action="delete" id="${person?.id}" class="btn btn-danger delete">
                                <i class="fa fa-trash-o" aria-hidden="true"></i>
                            </g:link>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <g:paginate total="${personCount ?: 0}" />
        </div>
    </div>
    </body>
</html>