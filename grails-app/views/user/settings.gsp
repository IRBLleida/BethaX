<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body crud">
                <h4 class="card-title">Configuració</h4>
                <hr class="brace">
                <g:form action='updatePassword' method="POST" id="loginForm" autocomplete="on" class="login-form">
                    <div class="alert alert-secondary" role="alert">
                        <g:message code="user.passwordExpired.passwordHelpText" />
                    </div>
                    <div class="form-group">
                        <label><g:message code="login.auth.username" />:</label>
                        <span class='text_'>${username}</span>
                    </div>
                    <div class="form-group">
                        <g:passwordField name='password' class='form-control' required="required" placeholder="${message(code: 'user.passwordExpired.currentPassword')}" />
                    </div>
                    <div class="form-group">
                        <g:passwordField name='password_new' class='form-control' min="6" max="64" required="required" placeholder="${message(code: 'user.passwordExpired.newPassword')}" />
                    </div>
                    <div class="form-group">
                        <g:passwordField name='password_new_2' class='form-control' min="6" max="64" required="required" placeholder="${message(code: 'user.passwordExpired.newPasswordAgain')}" />
                    </div>
                    <div class="form-check">
                        <button type="submit" class="btn btn-outline-primary"><g:message code="user.passwordExpired.reset" /></button>
                    </div>
                </g:form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
