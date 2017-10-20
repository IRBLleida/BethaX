<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="card border-secondary mb-3">
    <h4 class="card-header">
        Perfil de ${user}
    </h4>
    <div class="card-body">
        <g:if test="${!user.position && !user.website && !user.biography}">
            <div class="row">
                <div class="col">
                    <p class="lead">Sense informació de perfil</p>
                    <p class="card-text">Caram, quin perfil més desolat. Està tant buit que en Keanu Reeves està trist.</p>
                    <g:if test="${user == currentUser}">
                        <p class="card-text">Anima'l <g:link controller="user" action="edit">afegint la teva informació <i class="material-icons">tag_faces</i></g:link></p>
                    </g:if>
                </div>
                <div class="col-4">
                    <img src="https://files.gamebanana.com/img/ico/sprays/52ecd3c23c1b5.png" width="100%" />
                </div>
            </div>
        </g:if>
        <g:if test="${user.position}">
            <p class="card-text">
                <i class="material-icons">card_membership</i> ${user.position}
            </p>
        </g:if>
        <g:if test="${user.website}">
            <p class="card-text">
                <i class="material-icons">web</i> <a href="${user.website}" target="_blank">${user.website}</a>
            </p>
        </g:if>
        <g:if test="${user.biography}">
            <p class="card-text">
                <i class="material-icons">face</i> ${user.biography}
            </p>
        </g:if>
    </div>
</div>
</body>
</html>
