<div id="list-projectApplication" class="content scaffold-list" role="main">
    <g:if test="${flash.message}">
        <div class="alert alert-warning" role="alert">
            ${flash.message}
        </div>
    </g:if>

    <div class="panel-body">
        <table class="table">
            <thead>
            <tr>
                <th>Sol·licitud</th>
                <th>Projecte</th>
                <th>Acció</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="projectApplication" in="${projectApplicationList}">
                <g:if test="${projectApplication.state.value == id}">
                    <tr>
                        <td>
                            <g:link action="show" id="${projectApplication.id.toString()}">
                                ${projectApplication.name}
                            </g:link>
                        </td>
                        <td>
                            <g:link action="show" id="${projectApplication.id.toString()}">
                                ???
                            </g:link>
                        </td>
                        <td>
                            <g:link controller="projectApplication" action="edit" id="${projectApplication?.id}" params="[projectApplication: projectApplication?.id]" class="btn btn-warning">
                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            </g:link>
                            <g:link controller="projectApplication" action="delete" id="${projectApplication?.id}" class="btn btn-danger delete">
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
        <g:paginate total="${projectApplicationCount ?: 0}" />
    </div>
</div>