<div id="list-institution" class="content scaffold-list" role="main">
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
                <g:if test="${institution.institutionType.value == id}">
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
                        <g:link controller="institution" action="delete" id="${institution?.id}" class="btn btn-danger delete">
                            <i class="fa fa-trash-o" aria-hidden="true"></i>
                        </g:link>
                    </td>
                </tr>
                </g:if>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <g:paginate total="${institutionCount ?: 0}" />
    </div>
</div>