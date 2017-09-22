<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'institution.label', default: 'Institution')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div id="show-institution" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="row" style="margin-top: 20px;">
                <div class="col-md-4"></div>
                <div class="col-md-4" style="text-align: center;">
                    <h2>${institution.name}</h2> <br/>
                </div>
                <div class="col-md-4" style="text-align: right; padding-right: 50px">
                    <g:form resource="${this.institution}" method="DELETE">
                        <fieldset class="buttons">
                            <g:link controller="institution" action="edit" id="${institution?.id}" params="[institution: institution?.id]" class="btn btn btn-outline-warning">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i> Editar
                            </g:link>

                            <g:link controller="institution" action="delete" id="${institution?.id}" class="btn btn-danger delete"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                <i class="fa fa-trash-o" aria-hidden="true"></i>
                                Eliminar
                            </g:link>
                        </fieldset>
                    </g:form>
                </div>
            </div>


            <div style="text-align: center"><h4>Projectes</h4></div>

            <div class="panel-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Projecte</th>
                        <th>Estat</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td> Exemple </td>
                        <td> Finalitzat </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
