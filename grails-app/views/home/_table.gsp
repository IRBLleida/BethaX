<div id="list-institution" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="alert alert-warning" role="alert">
            ${flash.message}
        </div>
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
            <g:each var="institution" in="${institutionList.sort { -it.value }}">
                <g:if test="${institution.key.institutionType.value == id}">
                <tr>
                    <td>
                        <g:link controller="institution" action="show" id="${institution.key.id.toString()}">
                            ${institution.key.name}
                        </g:link>
                    </td>
                    <td>
                        ${institution.value}
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