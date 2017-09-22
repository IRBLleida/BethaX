<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="row" style="margin-top: 20px;">
            <div class="col-md-4"></div>
            <div class="col-md-4" style="text-align: center;">
                <h2>${person.name}</h2> <br/>
            </div>
            <div class="col-md-4" style="text-align: right; padding-right: 50px">
                <g:form resource="${this.person}" method="DELETE">
                    <fieldset class="buttons">
                        <g:link controller="person" action="edit" id="${person?.id}" params="[person: person?.id]" class="btn btn btn-outline-warning">
                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i> Editar
                        </g:link>
    
                        <g:link controller="person" action="delete" id="${person?.id}" class="btn btn-danger delete"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                            Eliminar
                        </g:link>
                    </fieldset>
                </g:form>
            </div>
            <div class="col-md-4" style="text-align: center;">Telèfon: <b><p>${person.phone}</p></b></div>
            <div class="col-md-4" style="text-align: center;">Correu electrònic: <b><p>${person.email}</p></b></div>
            <div class="col-md-4" style="text-align: center;">Institució: <b><p>${person.institution.name}</p></b></div>
        </div>
    <div style="text-align: center; margin-top:20px; margin-bottom: 20px;"><h4>Projectes</h4></div>

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
    </body>
</html>
