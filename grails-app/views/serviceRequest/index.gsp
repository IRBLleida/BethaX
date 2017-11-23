<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">Peticions <g:link controller="serviceRequest" action="create" target="_blank"><i class="fa fa-external-link" aria-hidden="true"></i></g:link></h4>
        <hr class="brace">
        <div class="row">
            <g:if test="${pendingServiceRequestList}">
                <div class="col-md-4">
                    <h5 class="text-center">Pendents d'aprovació</h5>
                    <table class="table table-warning">
                        <thead class="thead-inverse">
                        <tr>
                            <th><g:message code="serviceRequest.dateCreated.label" /></th>
                            <th>Sol·licitant</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="serviceRequest" in="${pendingServiceRequestList}">
                            <tr>
                                <th scope="row">
                                    <g:link action="show" id="${serviceRequest.id.toString()}">
                                        <g:formatDate date="${serviceRequest.dateCreated}" format="dd/MM/yyyy" />
                                    </g:link>
                                <td>${serviceRequest.name} (${serviceRequest.institution} - ${serviceRequest.department})</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </g:if>
            <g:if test="${approvedServiceRequestList}">
                <div class="col-md-4">
                    <h5 class="text-center">Aprovades</h5>
                    <table class="table table-success">
                        <thead class="thead-inverse">
                        <tr>
                            <th><g:message code="serviceRequest.dateCreated.label" /></th>
                            <th>Sol·licitant</th>
                            <th><g:message code="projectApplication.label" /></th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="serviceRequest" in="${approvedServiceRequestList}">
                            <tr>
                                <th scope="row">
                                    <g:link action="show" id="${serviceRequest.id.toString()}">
                                        <g:formatDate date="${serviceRequest.dateCreated}" format="dd/MM/yyyy" />
                                    </g:link>
                                <td>${serviceRequest.name} (${serviceRequest.institution} - ${serviceRequest.department})</td>
                                <td>
                                    <g:if test="${serviceRequest.projectApplication}">
                                        <g:link controller="projectApplication" action="show" id="${serviceRequest.projectApplication.id.toString()}">${serviceRequest.projectApplication}</g:link>
                                    </g:if>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </g:if>
            <g:if test="${refusedServiceRequestList}">
                <div class="col-md-4">
                    <h5 class="text-center">Refusades</h5>
                    <table class="table table-danger">
                        <thead class="thead-inverse">
                        <tr>
                            <th><g:message code="serviceRequest.dateCreated.label" /></th>
                            <th>Sol·licitant</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each var="serviceRequest" in="${refusedServiceRequestList}">
                            <tr>
                                <th scope="row">
                                    <g:link action="show" id="${serviceRequest.id.toString()}">
                                        <g:formatDate date="${serviceRequest.dateCreated}" format="dd/MM/yyyy" />
                                    </g:link>
                                <td>${serviceRequest.name} (${serviceRequest.institution} - ${serviceRequest.department})</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </div>
            </g:if>
        </div>
    </div>
</div>
</body>
</html>
