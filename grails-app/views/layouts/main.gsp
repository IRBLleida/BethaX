<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <g:layoutHead/>
</head>

<body>
    <oauth2:connect provider="github" id="github-connect-link">Github</oauth2:connect>

    Logged with Github?
    <oauth2:ifLoggedInWith provider="github">yes</oauth2:ifLoggedInWith>
    <oauth2:ifNotLoggedInWith provider="github">no</oauth2:ifNotLoggedInWith>

</body>
</html>
