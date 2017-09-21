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
    @import url("//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css");
    .login-block{
        background: #DE6262;  /* fallback for old browsers */
        background: -webkit-linear-gradient(to bottom, #FFB88C, #DE6262);  /* Chrome 10-25, Safari 5.1-6 */
        background: linear-gradient(to bottom, #FFB88C, #DE6262); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        float:left;
        width:100%;
        padding : 50px 0;
    }
    .banner-sec{background:url(https://static.pexels.com/photos/33972/pexels-photo.jpg)  no-repeat left bottom; background-size:cover; min-height:500px; border-radius: 0 10px 10px 0; padding:0;}
    .container{background:#fff; border-radius: 10px; box-shadow:15px 20px 0px rgba(0,0,0,0.1);}
    .carousel-inner{border-radius:0 10px 10px 0;}
    .carousel-caption{text-align:left; left:5%;}
    .login-sec{padding: 50px 30px; position:relative;}
    .login-sec .copy-text{position:absolute; width:80%; bottom:20px; font-size:13px; text-align:center;}
    .login-sec .copy-text i{color:#FEB58A;}
    .login-sec .copy-text a{color:#E36262;}
    .login-sec h2{margin-bottom:30px; font-weight:800; font-size:30px; color: #DE6262;}
    .login-sec h2:after{content:" "; width:100px; height:5px; background:#FEB58A; display:block; margin-top:20px; border-radius:3px; margin-left:auto;margin-right:auto}
    .btn-login{background: #DE6262; color:#fff; font-weight:600;}
    .banner-text{width:70%; position:absolute; bottom:40px; padding-left:20px;}
    .banner-text h2{color:#fff; font-weight:600;}
    .banner-text h2:after{content:" "; width:100px; height:5px; background:#FFF; display:block; margin-top:20px; border-radius:3px;}
    .banner-text p{color:#fff;}

    </style>
</head>
<body>
<section class="login-block">
    <div class="container">
        <div class="row">
            <div class="col-md-4 login-sec">
                <h2 class="text-center">BethaX</h2>
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
                <div class="copy-text">Created with <i class="fa fa-heart"></i> by <a href="http://www.irblleida.org/ca/index.php?p=webs/serveis_cientificotec/detall_servei.php&id=7">UBiostat</a></div>
            </div>
            <div class="col-md-8 banner-sec">
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner" role="listbox">
                        <div class="carousel-item active">
                            <img class="d-block img-fluid" src="https://static.pexels.com/photos/33972/pexels-photo.jpg" alt="First slide">
                            <div class="carousel-caption d-none d-md-block">
                                <div class="banner-text">
                                    <h2>This is Heaven</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img class="d-block img-fluid" src="https://images.pexels.com/photos/7097/people-coffee-tea-meeting.jpg" alt="First slide">
                            <div class="carousel-caption d-none d-md-block">
                                <div class="banner-text">
                                    <h2>This is Heaven</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</p>
                                </div>
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img class="d-block img-fluid" src="https://static.pexels.com/photos/33972/pexels-photo.jpg" alt="First slide">
                            <div class="carousel-caption d-none d-md-block">
                                <div class="banner-text">
                                    <h2>This is Heaven</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<asset:javascript src="application.js"/>

</body>
</html>
