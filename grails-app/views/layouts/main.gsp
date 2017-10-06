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
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarNavDropdown2" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" style="text-align: center">
        <img src="${resource(dir: 'images', file: 'logo.png')}"  style="width:40%;height:40%;"/>
    </a>

    <div class="collapse navbar-collapse order-3 order-lg-2" id="navbarNavDropdown2">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown">
                    Sol·licituds <span id="notificationsNumber" class="badge badge-secondary badge-info"> </span>
                </a>
                <div id="dropdownNotifications" class="dropdown-menu dropdown-menu-right">
                </div>
            </li>
        </ul>
    </div>

    <div class="collapse navbar-collapse order-lg-2">
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="#">Fites</a></li>
            <li class="nav-item"><a data-dialog="addSomethingDialog" class="nav-link" href="#"><i class="fa fa-plus-circle"></i></a></li>
        </ul>
    </div>

    <div class="collapse navbar-collapse order-lg-2">


        <div class="container">
            <div id="morphsearch" class="morphsearch">
                <form class="morphsearch-form">
                    <input class="morphsearch-input" type="search" placeholder="Buscar..."/>
                    <button class="morphsearch-submit" type="submit">Buscar</button>
                </form>
                <div class="morphsearch-content">
                    <div class="dummy-column">
                        <h2>Fites</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Acabar blabla</h3>
                        </a>
                        <a class="dummy-media-object" href="#">
                            <h3>Anàlisi A</h3>
                        </a>
                    </div>

                    <div class="dummy-column">
                        <h2>Sol·licituds</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Blabla</h3>
                        </a>
                        <a class="dummy-media-object" href="#">
                            <h3>Bleble</h3>
                        </a>
                    </div>

                    <div class="dummy-column">
                        <h2>Projectes</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Projecte A</h3>
                        </a>
                        <a class="dummy-media-object" href="">
                            <h3>Projecte B</h3>
                        </a>
                    </div>

                    <div class="dummy-column">
                        <h2>Persones</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Persona 1</h3>
                        </a>
                        <a class="dummy-media-object" href="">
                            <h3>Persona 2</h3>
                        </a>
                    </div>

                    <div class="dummy-column">
                        <h2>Institucions</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Institució X</h3>
                        </a>
                        <a class="dummy-media-object" href="">
                            <h3>Institució Y</h3>
                        </a>
                    </div>

                    <div class="dummy-column">
                        <h2>Usuaris</h2>
                        <a class="dummy-media-object" href="#">
                            <h3>Pau Balaguer</h3>
                        </a>
                        <a class="dummy-media-object" href="">
                            <h3>Jordi Vilaplana</h3>
                        </a>
                    </div>

                </div><!-- /morphsearch-content -->
                <span class="morphsearch-close"></span>
            </div><!-- /morphsearch -->

        </div><!-- /container -->


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
                    <g:link controller="user" action="show" class="nav-link ${controllerName == 'user' ? 'active2' : ''}" style="text-align: center">
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
    $.post("${createLink(controller: 'projectApplication', action: 'ajaxList')}", function(data) {
            $( "#notificationsNumber" ).html(data.length)
            dataset = data;
        });
    }

    a();
    setInterval(a, 30000);

    $('#navbarDropdownMenuLink2').on("click", function() {
        $.post("${createLink(controller: 'projectApplication', action: 'ajaxList')}", function(data) {
            if(isClosed){
                $("#dropdownNotifications").html("")
                for(var d in data) {
                    $("#dropdownNotifications").append('<a class="dropdown-item" href="#"><span class="user-dropwdown">' + data[d] + '</span></a>')
                }
                isClosed = false;
            }else{
                isClosed = true;
                dataset = [];
                $( "#notificationsNumber" ).html(0)
            }
        });
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


                        // trick to hide input text once the search overlay closes
                        // todo: hardcoded times, should be done after transition ends
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
    })();
</g:javascript>
<!-- Custom placeholder for page scripts -->
<g:ifPageProperty name="page.footScripts">
    <g:pageProperty name="page.footScripts" />
</g:ifPageProperty>
</body>
</html>
