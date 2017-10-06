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
    <asset:stylesheet src="application.css"/>
    <link href="https://fonts.googleapis.com/css?family=Bad+Script" rel="stylesheet">
    <asset:stylesheet src="mainLogIn.css" />
    <!--[if lte IE 9]><asset:stylesheet src="ie9.css" /><![endif]-->
</head>
<!--
<form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" autocomplete="on" class="login-form">
    <div class="form-group">
        <label for="username" class="text-uppercase">Username</label>
        <input type="email" id="username" name="username" class="form-control" placeholder="">

    </div>
    <div class="form-group">
        <label for="password" class="text-uppercase">Password</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="">
    </div>


    <div class="form-check">
        <label class="form-check-label">
            <input type="checkbox" id="remember_me" name="remember_me" class="form-check-input">
            <small>Remember Me</small>
        </label>
        <button type="submit" class="btn btn-login float-right">Submit</button>
    </div>

</form>
-->
<body class="is-loading">
<!-- Wrapper -->
<div id="wrapper">

    <!-- Header -->
    <header id="header">
        <div class="logo">
            <div><img src="${resource(dir: 'images', file: 'white-logo.png')}" style="width: 60%;padding-top: 15px;"/></div>
        </div>
        <div class="content">
            <div class="inner">
                <h1>Welcome to BethaX</h1>
                <p>The project management WebbApp developed by <a href="http://www.irblleida.org/ca/index.php?p=webs/serveis_cientificotec/detall_servei.php&id=7">UBiostat</a> team.</p>

                <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" autocomplete="on" class="login-form">
                    <div class="form-group">
                        <input type="email" id="username" name="username" class="form-control" placeholder="Username" style="color:#ffffff">
                    </div>
                    <div class="form-group">
                        <input type="password" id="password" name="password" class="form-control" placeholder="Password" style="color:#ffffff">
                    </div>
                    <div class="form-check">
                        <button type="submit" class="btn btn-login">Submit</button>
                    </div>

                </form>
            </div>
        </div>
        <nav>
            <ul>
                <li><a href="#work">BETHAX</a></li>
                <li><a href="#about">UBIOSTAT</a></li>
            </ul>
        </nav>
    </header>

    <!-- Main -->
    <div id="main">

        <!-- Work -->
        <article id="work">
            <h2 class="major">BethaX</h2>
            <span class="image main">
                <img src="${resource(dir: 'images', file: 'pic02.png')}"/>
            </span>
            <p>Adipiscing magna sed dolor elit. Praesent eleifend dignissim arcu, at eleifend sapien imperdiet ac. Aliquam erat volutpat. Praesent urna nisi, fringila lorem et vehicula lacinia quam. Integer sollicitudin mauris nec lorem luctus ultrices.</p>
        </article>

        <!-- About -->
        <article id="about">
            <h2 class="major">Ubiostat</h2>
            <span class="image main">
                <img src="${resource(dir: 'images', file: 'pic03.png')}"/>
            </span>
            <p>The Biostatistics (UBiostat) Service mission is to help generate knowledge to improve health. Statistical methods are essential for designing studies, analyze data and interpret results. We work with researchers to convert data into useful information to advance research.</p>
        </article>

    </div>

    <!-- Footer -->
    <footer id="footer">
        <p class="copyright">&copy; Page design: <a href="https://html5up.net">HTML5 UP</a>.</p>
    </footer>

</div>

<!-- BG -->
<div id="bg"></div>

<asset:javascript src="application.js"/>
</body>
</html>
