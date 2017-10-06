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
            <div class="feed-item">
                <div class="date">25 Set 2017</div>
                <div class="text">Ha finalitzat la fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Jordi Vilanova</div>
            </div>
            <div class="feed-item">
                <div class="date">24 Set 2017</div>
                <div class="text">Ha creat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">10 Set 2017</div>
                <div class="text">Ha creat un nou projecte <a href="#">[NOM PROJECTE]</a></div>
                <div class="person">Montse Rué</div>
            </div>
            <div class="feed-item">
                <div class="date">29 Ago 2017</div>
                <div class="text">Ha creat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">15 Ago 2017</div>
                <div class="text">Ha finalitzat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Jordi Vilanova</div>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card border-info mb-3">
            <div class="card-body text-info" style="text-align: center">
                <h4 class="card-title mt-0 mb-0">Activitat Personal</h4>
            </div>
        </div>
        <div class="activity-feed">
            <div class="feed-item">
                <div class="date">24 Set 2017</div>
                <div class="text">Ha creat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">10 Set 2017</div>
                <div class="text">Ha creat un nou projecte <a href="#">[NOM PROJECTE]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">29 Ago 2017</div>
                <div class="text">Ha creat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">15 Ago 2017</div>
                <div class="text">Ha finalitzat una nova fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">2 Ago 2017</div>
                <div class="text">Ha finalitzat la fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">22 Jul 2017</div>
                <div class="text">Ha finalitzat la fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
            <div class="feed-item">
                <div class="date">21 Jul 2017</div>
                <div class="text">Ha finalitzat la fita <a href="#">[NOM FITA]</a></div>
                <div class="person">Pau Balaguer</div>
            </div>
        </div>
    </div>
</div>
</body>