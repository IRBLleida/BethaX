<html>
<head>
    <title><g:message code='springSecurity.login.title'/></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <asset:link rel="apple-touch-icon" sizes="57x57" href="apple-icon-57x57.png"/>
    <asset:link rel="apple-touch-icon" sizes="60x60" href="apple-icon-60x60.png"/>
    <asset:link rel="apple-touch-icon" sizes="72x72" href="apple-icon-72x72.png"/>
    <asset:link rel="apple-touch-icon" sizes="76x76" href="apple-icon-76x76.png"/>
    <asset:link rel="apple-touch-icon" sizes="114x114" href="apple-icon-114x114.png"/>
    <asset:link rel="apple-touch-icon" sizes="120x120" href="apple-icon-120x120.png"/>
    <asset:link rel="apple-touch-icon" sizes="144x144" href="apple-icon-144x144.png"/>
    <asset:link rel="apple-touch-icon" sizes="152x152" href="apple-icon-152x152.png"/>
    <asset:link rel="apple-touch-icon" sizes="180x180" href="apple-icon-180x180.png"/>
    <asset:link rel="icon" type="image/png" sizes="192x192"  href="android-icon-192x192.png"/>
    <asset:link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
    <asset:link rel="icon" type="image/png" sizes="96x96" href="favicon-96x96.png"/>
    <asset:link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
    <asset:stylesheet src="bootstrap.css"/>
    <asset:stylesheet src="font-awesome.min.css"/>
    <asset:stylesheet src="nprogress.css"/>
    <asset:stylesheet src="animate.css"/>
    <asset:stylesheet src="main.css"/>
    <asset:stylesheet src="auth.css" />
    <asset:javascript src="jquery-2.2.0.min.js" />
    <link href="https://fonts.googleapis.com/css?family=Bad+Script" rel="stylesheet">
    <style>
    span {
        font-family: monospace;
        font-size: 2em;
    }

    span:after {
        content: "_";
        opacity: 0;
        animation: cursor 1s infinite;
    }

    @keyframes cursor {
        0% {
            opacity: 0;
        }
        40% {
            opacity: 0;
        }
        50% {
            opacity: 1;
        }
        90% {
            opacity: 1;
        }
        100% {
            opacity: 0;
        }
    }
    /* styling */
    html {
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, #ffffff 0%, #aaaaaa 100%) no-repeat;
        overflow-x: hidden;
        overflow-y: hidden;
    }

    body {
        text-align: center;
        display: table;
        width: 100%;
        height: 100%;
        overflow-x: hidden;
        overflow-y: hidden;
    }

    #wrap {
        box-sizing: border-box;
        display: table-cell;
        vertical-align: middle;
    }

    </style>
</head>
<body>

                <g:if test="${flash.error}">
                    <div class="alert alert-error" style="display: block; text-shadow: none;">${flash.error}</div>
                </g:if>
                <g:if test="${flash.message}">
                    <div class="alert alert-info" style="text-shadow: none;">
                        ${flash.message}
                        <%--<g:message code="${flash.message}" />--%>
                    </div>
                </g:if>
                <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" autocomplete="on">
                    <div id="wrap">
                        <span>root@bethax:~$ </span>
                    </div>

                    <h1>Betha<strong style="color: #95004f;">X</strong></h1>
                    <div>
                        <input type="email" class="form-control" placeholder="${g.message(code: 'login.auth.username')}" required="" name="${usernameParameter ?: 'username'}" id="username" autofocus />
                    </div>
                    <div>
                        <input type="password" class="form-control" placeholder="${g.message(code: 'login.auth.password')}" required="" name="${passwordParameter ?: 'password'}" id="password" />
                    </div>
                    <div class="form-group">
                        <input type="submit" id="submit" class="btn btn-default submit" value="${g.message(code: 'springSecurity.login.button')}"/>
                        <a href="#password_reset" class="to_register" href="#"><g:message code="login.auth.lostPassword" /></a>
                    </div>

                    <div class="clearfix"></div>

                    <div class="separator">
                        <div>
                            <asset:image src="logo_irblleida.png" style="margin-top: 20px; max-width: 180px;" />
                        </div>
                    </div>
                </form>

</body>
</html>
