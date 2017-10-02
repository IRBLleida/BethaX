<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>
        <g:layoutTitle default="BethaX"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body>
<nav class="navbar fixed-top navbar-light navbar-expand-lg navbar-template">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" style="text-align: center">
        <img src="${resource(dir: 'images', file: 'logo.png')}"  style="width:40%;height:40%;"/>
    </a>

    <div class="collapse navbar-collapse order-lg-2">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="#">Sol·licituds</a></li>
            <li class="nav-item"><a class="nav-link" href="#">Fites</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fa fa-plus-circle"></i></a></li>
        </ul>
    </div>

    <div class="collapse navbar-collapse order-lg-2">
        <form class="form-inline">
            <input class="form-control mr-sm-4" type="text" placeholder="Buscar" aria-label="Buscar">
            <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Buscar</button>
        </form>
    </div>
    <div class="collapse navbar-collapse order-3 order-lg-2" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown">
                    <sec:loggedInUserInfo field="givenName" /> <sec:loggedInUserInfo field="familyName" />
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <a class="dropdown-item" href="#"><i class="fa fa-user"></i> <span class="user-dropwdown">Perfil</span></a>
                    <a class="dropdown-item" href="#"><i class="fa fa-cog"></i> <span class="user-dropwdown">Configuració</span></a>
                    <g:link class="dropdown-item" controller="logout" action="index"><i class="fa fa-sign-out"></i> <span class="user-dropwdown">Tancar sessió</span></g:link>
                </div>
            </li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <nav class="col-sm-3 col-md-2 d-none d-sm-block bg-light sidebar">

            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <g:link controller="user" action="index" id="" class="nav-link ${controllerName == 'user' ? 'active2' : ''}" style="text-align: center">
                        <img src="${resource(dir: 'images', file: 'user.png')}"  style="width:80px;height:80px;"/>
                        <br/><br/>
                        <sec:loggedInUserInfo field="givenName" /> <sec:loggedInUserInfo field="familyName" />
                    </g:link>
                </li>
            </ul>

            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <g:link controller="home" action="summary" class="nav-link ${actionName == 'summary' ? 'active' : ''}">
                        <i class="fa fa-tachometer"></i>
                        Resum <span class="sr-only">(current)</span>
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link controller="home" action="calendar" class="nav-link ${actionName == 'calendar' ? 'active' : ''}">
                        <i class="fa fa-calendar"></i>
                        Calendari
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link controller="home" action="activity" class="nav-link ${actionName == 'activity' ? 'active' : ''}">
                        <i class="fa fa-users"></i>
                        Activitat
                    </g:link>
                </li>
            </ul>

            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <g:link controller="project" action="index" class="nav-link ${controllerName == 'project' ? 'active' : ''}">
                        <i class="fa fa-archive"></i>
                        Projectes
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link controller="projectApplication" action="index" class="nav-link ${controllerName == 'projectApplication' ? 'active' : ''}">
                        <i class="fa fa-wpforms"></i>
                        Sol·licituds
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link controller="institution" action="index" class="nav-link ${controllerName == 'institution' ? 'active' : ''}">
                        <i class="fa fa-building"></i>
                        Institucions
                    </g:link>
                </li>
                <li class="nav-item">
                    <g:link controller="person" action="index" class="nav-link ${controllerName == 'person' ? 'active' : ''}">
                        <i class="fa fa-user-circle-o "></i>
                        Persones
                    </g:link>
                </li>
            </ul>

            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fa fa-question-circle"></i>
                        Ajuda
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <i class="fa fa-bug"></i>
                        Reportar un problema
                    </a>
                </li>
            </ul>
        </nav>
        <main class="col-sm-9 ml-sm-auto col-md-10 pt-3" role="main">
            <g:layoutBody/>
        </main>
    </div>
</div>
<asset:javascript src="application.js"/>
<!-- Custom placeholder for page scripts -->
<g:ifPageProperty name="page.footScripts">
    <g:pageProperty name="page.footScripts" />
</g:ifPageProperty>
</body>
</html>
