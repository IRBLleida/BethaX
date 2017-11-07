<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:stylesheet src="feed.css"/>
    <style>
    .col-md-12 .pull-right{
        margin-top: 10px;
        margin-bottom: 20px;
    }
    </style>
</head>
<body>

<div class="row mt-3">
    <div class="col-md-6 pl-4">
        <div class="card border-info mb-3">
            <div class="card-body text-info" style="text-align: center">
                <h4 class="card-title mt-0 mb-0">Activitat General</h4>
            </div>
        </div>
        <div class="activity-feed">
            <g:each var="event" in="${applicationEventList}">
                <div class="feed-item">
                    <div class="date">${event.dateCreated}</div>
                    <div class="text"><g:message code="home.activity.layout" args="[event.action, event.domainObject]"/> [${event.objectName}]</div>
                    <div class="person">${event.triggeredBy.givenName} ${event.triggeredBy.familyName}</div>
                </div>
            </g:each>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card border-info mb-3">
            <div class="card-body text-info" style="text-align: center">
                <h4 class="card-title mt-0 mb-0">Activitat Personal</h4>
            </div>
        </div>
        <div class="activity-feed">
            <g:each var="event" in="${applicationEventListUser}">
                <div class="feed-item">
                    <div class="date">${event.dateCreated}</div>
                    <div class="text"><g:message code="home.activity.layout" args="[event.action, event.domainObject]"/> [${event.objectName}]</div>
                    <div class="person">${event.triggeredBy.givenName} ${event.triggeredBy.familyName}</div>
                </div>
            </g:each>
        </div>
    </div>
</div>
</body>