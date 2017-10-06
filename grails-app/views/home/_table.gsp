<div id="list-institution" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <div class="panel-body">
        <table class="table">
            <thead>
            <tr>
                <th>Institució</th>
                <th>Nombre</th>
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
                        5
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