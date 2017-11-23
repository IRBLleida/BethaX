<div id="list-milestone" class="content scaffold-list" role="main">
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
                <th>Acció</th>
            </tr>
            </thead>
            <tbody>
            <g:each var="milestone" in="${milestoneList}">
                <g:if test="${id == 0}">
                    <g:if test="${milestone.dateFinished == null}">
                        <tr>
                            <td>
                                <g:link action="show" id="${milestone.id.toString()}">
                                    ${milestone.name}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="milestone" action="edit" id="${milestone?.id}" params="[milestone: milestone?.id]" class="btn btn-warning">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </g:link>
                                <g:link controller="milestone" action="delete" id="${milestone?.id}" class="btn btn-danger delete">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                </g:link>
                            </td>
                        </tr>
                    </g:if>
                </g:if><g:else>
                    <g:if test="${milestone.dateFinished != null}">
                        <tr>
                            <td>
                                <g:link action="show" id="${milestone.id.toString()}">
                                    ${milestone.name}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="milestone" action="edit" id="${milestone?.id}" params="[milestone: milestone?.id]" class="btn btn-warning">
                                    <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                                </g:link>
                                <g:link controller="milestone" action="delete" id="${milestone?.id}" class="btn btn-danger delete">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>
                                </g:link>
                            </td>
                        </tr>
                    </g:if>
                </g:else>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <g:paginate total="${milestoneCount ?: 0}" />
    </div>
</div>