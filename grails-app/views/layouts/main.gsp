<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>
        <g:layoutTitle default="BethaX"/>
    </title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <g:layoutHead/>

    <style>
    .input-group .form-control {
        z-index: 0;
    }
    a.disabled {
        pointer-events: none;
    }

</style>
</head>
<body>
<nav class="navbar fixed-top navbar-light navbar-expand-lg navbar-template">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <g:link controller="home" action="index" class="navbar-brand">
        <img src="${resource(dir: 'images', file: 'logo.png')}"  style="padding-left: 20px; height:35px;"/>
    </g:link>
    <div class="collapse navbar-collapse order-3 order-lg-2" id="navbarNavDropdown2">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown">
                    Peticions <span id="notificationsNumber" class="badge badge-secondary badge-info"> </span>
                </a>
                <div id="dropdownNotifications" class="dropdown-menu ">
                </div>
            </li>
        </ul>
    </div>
    <div class="collapse navbar-collapse order-lg-2">
        <ul class="navbar-nav">
            <li class="nav-item"><g:link class="nav-link" controller="milestone" action="index">Fites</g:link></li>
            <li class="nav-item"><a data-dialog="addSomethingDialog" class="nav-link" href="#"><i class="fa fa-plus-circle"></i></a></li>
        </ul>
    </div>
    <div class="collapse navbar-collapse order-lg-2">
        <div class="container">
            <div id="morphsearch" class="morphsearch">
                <form class="morphsearch-form">
                    <input class="morphsearch-input" id="search" type="search" placeholder="Cercar ..." autocomplete="off" />
                    <button class="morphsearch-submit" type="submit">A</button>
                </form>
                <div class="morphsearch-content">
                    <div style="color: #c2c2c2; margin: 0 auto; width: 80%;">
                        <g:link style="color: #c2c2c2;" controller="search" action="advanced"><i id="options" class="fa fa-search-plus" aria-hidden="true"></i> Cerca avançada</g:link>
                    </div>

                    <div id="emptyResults" class="row">
                        <div class="col-md-12" style="text-align: center; margin-top: 50px;"> <asset:image src="loading.gif" width="500" style="opacity: 0.4;"/> </div>
                    </div>
                    <br/>
                    <div id="resultsSection" class="row">
                        <div class="dummy-column" id="milestones">
                            <h2>Fites</h2>
                            <div id="search-milestone">

                            </div>
                        </div>

                        <div class="dummy-column" id="projectApplications">
                            <h2>Sol·licituds</h2>
                            <div id="search-projectApplication">

                            </div>
                        </div>

                        <div class="dummy-column" id="projects">
                            <h2>Projectes</h2>
                            <div id="search-project">

                            </div>
                        </div>

                        <div class="dummy-column" id="persons">
                            <h2>Persones</h2>
                            <div id="search-person">

                            </div>
                        </div>

                        <div class="dummy-column" id="institutions">
                            <h2>Institucions</h2>
                            <div id="search-institution">

                            </div>
                        </div>

                        <div class="dummy-column" id="users">
                            <h2>Usuaris</h2>
                            <div id="search-user">

                            </div>
                        </div>
                    </div>

                </div>
                <span class="morphsearch-close"></span>
            </div>

        </div>
    </div>
    <div class="collapse navbar-collapse order-3 order-lg-2" id="navbarNavDropdown">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown">
                    <sec:loggedInUserInfo field="givenName" /> <sec:loggedInUserInfo field="familyName" />
                </a>
                <div class="dropdown-menu dropdown-menu-right">
                    <g:link controller="user" action="show" class="dropdown-item"><i class="fa fa-user"></i> <span class="user-dropwdown">Perfil</span></g:link>
                    <g:link controller="user" action="settings" class="dropdown-item"><i class="fa fa-cog"></i> <span class="user-dropwdown">Configuració</span></g:link>
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
                    <g:link controller="user" action="show" class="nav-link ${controllerName == 'user' ? 'active2' : ''}" style="text-align: center">
                        <img class="card-img-top rounded-circle" src="${createLink(controller: 'user', action: 'photo')}"  style="width:80px;height:80px;"/>
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
                    <g:link controller="workPlan" action="index" class="nav-link ${controllerName == 'workPlan' ? 'active' : ''}">
                        <i class="fa fa-book"></i>
                        Plans de treball
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
                    <a class="nav-link" href="https://github.com/IRBLleida/BethaX/issues/new?labels=sol%C2%B7licitud%20d%27ajuda&assignees=pbalaguer19" target="_blank">
                        <i class="fa fa-question-circle"></i>
                        <g:message code="layouts.main.requestHelp" />
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="https://github.com/IRBLleida/BethaX/issues/new?labels=error&assignees=pbalaguer19" target="_blank">
                        <i class="fa fa-bug"></i>
                        <g:message code="layouts.main.reportBug" />
                    </a>
                </li>
            </ul>
        </nav>
        <main class="col-sm-9 ml-sm-auto col-md-10 pt-3" role="main">
            <g:layoutBody/>
            <div id="addSomethingDialog" class="dialog dialog--close">
                <div class="dialog__overlay"></div>
                <div class="dialog__content">
                    <div class="morph-shape">
                        <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 560 280" preserveAspectRatio="none">
                            <rect x="3" y="3" fill="none" width="556" height="276"></rect>
                        </svg>
                    </div>
                    <div class="dialog-inner">
                        <h2><strong>Hola</strong>, què vols afegir avui?</h2>
                        <div class="row">
                            <div class="col-md-3">
                                <g:link controller="project" action="create" class="btn btn-outline-primary">Projecte</g:link>
                            </div>
                            <div class="col-md-3">
                                <g:link controller="projectApplication" action="create" class="btn btn-outline-info">Sol·licitud</g:link>
                            </div>
                            <div class="col-md-3">
                                <g:link controller="institution" action="create" class="btn btn-outline-primary">Institució</g:link>
                            </div>
                            <div class="col-md-3">
                                <g:link controller="person" action="create" class="btn btn-outline-info">Persona</g:link>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 mt-5">
                                <p>
                                    <a href="#" class="btn btn-outline-secondary" data-dialog-close="a">Tancar</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<asset:javascript src="application.js" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.js"></script>
<g:javascript>
    $(function() {
        $('.input-group.date').datepicker({
            format: "dd/mm/yyyy",
            weekStart: 1,
            todayBtn: "linked",
            language: "ca",
            autoclose: true
        });
    });
</g:javascript>
<g:javascript>
    (function() {
        var dlgtrigger = document.querySelector( '[data-dialog]' ),
            somedialog = document.getElementById( dlgtrigger.getAttribute( 'data-dialog' ) ),
            dlg = new DialogFx( somedialog );
        dlgtrigger.addEventListener( 'click', dlg.toggle.bind(dlg) );
    })();
</g:javascript>
<g:javascript>
    var isClosed = true;
    var dataset = [];

    function a() {
    $.post("${createLink(controller: 'serviceRequest', action: 'ajaxList')}", function(data) {
            $( "#notificationsNumber" ).html(data.length);
            dataset = data;
        });
    }

    $(function(){setTimeout(function () {
            a();
    },1000)});

    setInterval(a, 30000);

    $('#navbarDropdownMenuLink2').on("click", function() {
        if(isClosed){
            $.post("${createLink(controller: 'serviceRequest', action: 'ajaxList')}", function(data) {
                $("#dropdownNotifications").html("");
                $("#dropdownNotifications").append('<h6 class="dropdown-header">Pendents</h6>');
                for(var d in data) {
                    $("#dropdownNotifications").append('<a class="dropdown-item" href="${createLink(controller: 'serviceRequest', action: 'show')}/' + data[d].id + '"><span class="user-dropwdown text-danger">' + data[d].name + ' (' + data[d].institution + ')</span></a>');
                }
                $("#dropdownNotifications").append('<div class="dropdown-divider"></div><a class="dropdown-item" href="${createLink(controller: 'serviceRequest', action: 'index')}"><span class="user-dropwdown text-info"><i class="fa fa-archive" aria-hidden="true"></i> Mostrar totes</span></a>');
                isClosed = false;
            });
        }else{
            isClosed = true;
        }
    })
</g:javascript>
<g:javascript>
    (function() {
        var morphSearch = document.getElementById( 'morphsearch' ),
                input = morphSearch.querySelector( 'input.morphsearch-input' ),
                ctrlClose = morphSearch.querySelector( 'span.morphsearch-close' ),
                isOpen = isAnimating = false,
                // show/hide search area
                toggleSearch = function(evt) {
                    // return if open and the input gets focused
                    if( evt.type.toLowerCase() === 'focus' && isOpen ) return false;

                    morphSearch.style.position = 'fixed';

                    var offsets = morphsearch.getBoundingClientRect();
                    if( isOpen ) {
                        classie.remove( morphSearch, 'open' );

                        if( input.value !== '' ) {
                            setTimeout(function() {
                                classie.add( morphSearch, 'hideInput' );
                                setTimeout(function() {
                                    classie.remove( morphSearch, 'hideInput' );
                                    input.value = '';
                                }, 300 );
                            }, 500);
                        }

                        input.blur();
                        morphSearch.style.position = 'inherit';

                    }
                    else {
                        classie.add( morphSearch, 'open' );
                    }
                    isOpen = !isOpen;
                };

        // events
        input.addEventListener( 'focus', toggleSearch );
        ctrlClose.addEventListener( 'click', toggleSearch );
        // esc key closes search overlay
        // keyboard navigation events
        document.addEventListener( 'keydown', function( ev ) {
            var keyCode = ev.keyCode || ev.which;
            if( keyCode === 27 && isOpen ) {
                toggleSearch(ev);
            }
        } );

        /***** for demo purposes only: don't allow to submit the form *****/
        morphSearch.querySelector( 'button[type="submit"]' ).addEventListener( 'click', function(ev) { ev.preventDefault(); } );

        var delay = (function() {
            var timer = 0;
            return function(callback, ms){
                clearTimeout (timer);
                timer = setTimeout(callback, ms);
            };
        })();

        $('#search').keyup(function() {
            delay(function() {
                if($('#search').val() == '') {
                    noWords();
                    return;
                }

                var searchField = $('#search').val();
                $.getJSON('<g:createLink controller="home" action="search" />', {
                    query: searchField
                }).done(function(data) {

                    if(data.length == 0){
                        noWords();
                        return;
                    }

                    $('#emptyResults').hide();
                    $('#resultsSection').show();

                    var output = '';
                    if(data.requests.length == 0) {
                        $('#projectApplications').hide();
                    }
                    else {
                        $('#projectApplications').show();
                        $.each(data.requests, function(key, val) {
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="projectApplication" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3>' + val.name + ' (' + val.projects + ')</h3></a>';
                        });
                        $('#search-projectApplication').html(output);
                    }

                    if(data.projects.length == 0){
                        $('#projects').hide();
                    }
                    else{
                        $('#projects').show();
                        output = '';
                        $.each(data.projects, function(key, val) {
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="project" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3>' + val.name +'</h3></a>';
                        });
                        $('#search-project').html(output);
                    }

                    if(data.milestones.length == 0){
                        $('#milestones').hide();
                    }
                    else{
                        $('#milestones').show();
                        output = '';
                        $.each(data.milestones, function(key, val) {
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="workPlan" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3>' + val.name +' <div style="float: right;">' + val.date +'</div></h3></a>';
                        });
                        $('#search-milestone').html(output);
                    }

                    if(data.persons.length == 0){
                        $('#persons').hide();
                    }
                    else{
                        $('#persons').show();
                        output = '';
                        $.each(data.persons, function(key, val) {
                            var photo = '<g:createLink controller="person" action="photo"/>/' + val.id;
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="person" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3> <img src="' + photo + '" width="100" class="rounded-circle animated pulse" />' +
                                        val.name +' (' + val.institution + ')</h3></a>';
                        });
                        $('#search-person').html(output);
                    }

                    if(data.institutions.length == 0){
                        $('#institutions').hide();
                    }
                    else{
                        $('#institutions').show();
                        output = '';
                        $.each(data.institutions, function(key, val) {
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="institution" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3>' + val.name +'</h3></a>';
                        });
                        $('#search-institution').html(output);
                    }

                    if(data.users.length == 0){
                        $('#users').hide();
                    }
                    else{
                        $('#users').show();
                        output = '';
                        $.each(data.users, function(key, val) {
                            var photo = '<g:createLink controller="user" action="photo"/>/' + val.id;
                            console.log(photo)
                            output +=   '<a class="dummy-media-object" href="<g:createLink controller="user" action="show"/>/' + val.id +
                                        '" class="list-group-item">' + '<h3> <img src="' + photo + '" width="100" class="rounded-circle animated pulse" />' +
                                        val.name +' (' + val.username + ')</h3></a>';
                        });
                        $('#search-user').html(output);
                    }

                });
            }, 500);
         });
    })();
</g:javascript>
<g:javascript>
noWords();
function noWords() {
    $('#emptyResults').show();
    $('#resultsSection').hide();
}
</g:javascript>
<!-- Custom placeholder for page scripts -->
<g:ifPageProperty name="page.footScripts">
    <g:pageProperty name="page.footScripts" />
</g:ifPageProperty>
</body>
</html>
