<!doctype html>
<html>
    <head>
        <title>Page Not Found</title>
        <g:if env="development"><asset:stylesheet src="errors.css"/></g:if>
    </head>
    <body>

    <div class="jumbotron" style="text-align: center;">
        <h1 class="display-3">
            <asset:image src="404.png" />
        </h1>
        <h3 class="display-4">Aquesta pàgina no existeix!</h3>
        <hr class="my-4">
        <p>Has intentat accedir a ${request.forwardURI}</p>

    </div>
    </body>
</html>
