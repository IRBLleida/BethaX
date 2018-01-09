<%@ page import="org.irblleida.bethax.Person" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <style>
    @media (max-width: 767px) {
        .visible-xs {
            display: inline-block !important;
        }
        .block {
            display: block !important;
            width: 100%;
            height: 1px !important;
        }
    }
    #back-to-bootsnipp {
        position: fixed;
        top: 10px; right: 10px;
    }




    .c-list {
        padding: 0px;
        min-height: 44px;
    }
    .title {
        display: inline-block;
        font-size: 1.7em;
        font-weight: bold;
        padding: 5px 15px;
    }
    ul.c-controls {
        list-style: none;
        margin: 0px;
        min-height: 44px;
    }

    ul.c-controls li {
        margin-top: 8px;
        float: left;
    }

    ul.c-controls li a {
        font-size: 1.7em;
        padding: 11px 10px 6px;
    }
    ul.c-controls li a i {
        min-width: 24px;
        text-align: center;
    }

    ul.c-controls li a:hover {
        background-color: rgba(51, 51, 51, 0.2);
    }

    .c-toggle {
        font-size: 1.7em;
    }

    .name {
        font-size: 1.7em;
        font-weight: 700;
    }
    </style>
</head>
<body>
<g:if test="${flash.message}">
    <div class="alert alert-warning" role="alert">
        ${flash.message}
    </div>
</g:if>
<div class="card">
    <div class="card-body crud">
        <h4 class="card-title">
            Persones
            <span class="pull-right">
                <g:link action="create" data-toggle="tooltip" data-placement="left" title="Afegir contacte"><i class="fa fa-user-plus" aria-hidden="true"></i></g:link>
            <%--
            <a href="#" class="hide-search" data-command="toggle-search" data-toggle="tooltip" data-placement="top" title="Mostra la cerca" style="margin-left: 10px; padding-left: 10px; padding-right: 10px;"><i class="fa fa-ellipsis-v"></i></a>
            --%>
        </span>
        </h4>
        <div class="row" style="display: none;">
            <div class="col align-self-center">
                <div class="input-group c-search">
                    <input type="text" class="form-control" id="contact-list-search">
                    <span class="input-group-addon">
                        <i class="fa fa-search" aria-hidden="true"></i>
                    </span>
                </div>
                <hr />
            </div>

        </div>
        <div class="list-group" id="contact-list">
            <div id="contact-list-content" class="row">
                <g:each var="person" in="${personList}">
                    <div class="col-xs-12 col-md-6 personElement">
                        <div class="list-group-item">
                            <div class="row">
                                <div class="col-xs-12 col-sm-4 col-md-4">
                                    <g:link action="show" id="${person.id.toString()}">
                                        <img src="${createLink(action: 'photo', id: person.id.toString())}" width="128" height="128" alt="${person.name}" class="rounded-circle animated pulse" />
                                    </g:link>
                                </div>
                                <div class="col-xs-12 col-sm-8 col-md-8">
                                    <span class="name searchable">${person.name}</span><br/>
                                    <span class="c-info text-muted searchable">
                                        <i class="fa fa-building-o" aria-hidden="true"></i>
                                        ${person.institution} ${person.section ? '- ' + person.section : person.section}
                                    </span>
                                    <br />
                                    <span class="c-info text-muted searchable">
                                        <i class="fa fa-phone" aria-hidden="true"></i>
                                        ${person.phone}
                                    </span>
                                    <br />
                                    <span class="c-info text-muted searchable">
                                        <i class="fa fa-comments" aria-hidden="true"></i>
                                        <a href="mailto:${person.email}">${person.email}</a>
                                    </span>
                                    <br />
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </g:each>
            </div>
            <div class="row">
                <div class="col-md-12" style="margin-top: 30px;">
                    <g:paginate controller="person" action="index" total="${personCount}" />
                </div>
            </div>
        </div>
        <g:if test="${!personList}">
            <div class="jumbotron">
                <h1 class="display-3">
                    <asset:image src="open-box.png" />
                    Ups ...
                </h1>
                <p class="lead">Casum l'òs pedrer, encara no hi ha cap ${message(code: "person.label")?.toLowerCase()}!</p>
                <hr class="my-4">
                <p>Pots afegir-ne fent clic al botó de sota.</p>
                <p class="lead">
                    <g:link action="create" class="btn btn-outline-primary btn-lg"><g:message code="default.create.label" args="[message(code: 'person.label')?.toLowerCase()]" /></g:link>
                </p>
            </div>
        </g:if>
    </div>
</div>
<content tag="footScripts">
<g:javascript>
    $(function () {
        $('[data-toggle="tooltip"]').tooltip();

        $('[data-command="toggle-search"]').on('click', function(event) {
            event.preventDefault();
            $(this).toggleClass('hide-search');

            if ($(this).hasClass('hide-search')) {
                $('.c-search').closest('.row').slideUp(100);
            }else{
                $('.c-search').closest('.row').slideDown(100);
            }
        })

        $('#contact-list').searchable({
            searchField: '#contact-list-search',
            selector: 'div.personElement',
            childSelector: '.col-xs-12',
            show: function( elem ) {
                elem.slideDown(100);
            },
            hide: function( elem ) {
                elem.slideUp( 100 );
            }
        })
    });
</g:javascript>
</content>
</body>
</html>
