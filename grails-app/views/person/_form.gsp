<%@ page import="org.irblleida.bethax.Person" %>
<g:if test="${flash.message}">
    <div class="alert alert-info" role="alert">${flash.message}</div>
</g:if>
<g:hasErrors bean="${this.person}">
    <div class="alert alert-warning" role="alert">
        <g:eachError bean="${this.person}" var="error">
            <p <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></p>
        </g:eachError>
    </div>
</g:hasErrors>
<div class="row">
    <bx:formField bean="${this.person}" property="institution" required="required" />
    <div class="col-md-3">
        <label>&nbsp;</label>
        <g:link controller="institution" action="create" class="btn btn-outline-success form-control"><i class="fa fa-building" aria-hidden="true"></i> Nova institució</g:link>
    </div>
    <bx:formField bean="${this.person}" property="section" />
    <div class="col-md-3">
        <label>&nbsp;</label>
        <g:link controller="institutionSection" action="create" class="btn btn-outline-success form-control"><i class="fa fa-users" aria-hidden="true"></i> Nova secció</g:link>
    </div>
</div>
<div class="row">
    <bx:formField bean="${this.person}" property="name" />
    <bx:formField bean="${this.person}" property="phone" />
    <bx:formField bean="${this.person}" property="email" />
    <div class="col-md-3">
        <div class="form-group">
            <label>Foto</label>
            <label class="custom-file form-control">
                <input type="file" id="photo" name="photo" class="custom-file-input" aria-describedby="photoHelpBlock">
                <span class="custom-file-control form-control-file"></span>
            </label>
            <small id="photoHelpBlock" class="form-text text-muted">
                Mida recomanda: 128 x 128 píxels.
            </small>
        </div>
    </div>
</div>
<content tag="footScripts">
    <g:javascript>
        $('.custom-file-input').on('change',function(){
            var fileName = $(this).val();
            if(fileName.length > 30) fileName = '... ' + fileName.substr(fileName.length - 27);
            $(this).next('.form-control-file').addClass("selected").html(fileName);
        });
        $('#institution').val('${this.person.institution.id}');

        $.ajax({
            url: "${g.createLink(controller: 'institutionSection', action: 'findByInstitution')}",
            data: { id: $('#institution').val() },
            dataType: "json",
            success: function(sections) {
                console.log(sections);
                var name, select, option;

                // Get the raw DOM object for the select box
                select = document.getElementById('section');

                // Clear the old options
                select.options.length = 0;

                // Load the new options
                $.each(sections, function(index, section) {
                    select.options.add(new Option(section.name, section.id));
                });
                $('#section').val('${this.person?.section.id}');
            }
        });

        $('#institution').on('change', function() {
            console.log('wo');
            $.ajax({
                url: "${g.createLink(controller: 'institutionSection', action: 'findByInstitution')}",
                data: { id: $('#institution').val() },
                dataType: "json",
                success: function(sections) {
                    console.log(sections);
                    var name, select, option;

                    // Get the raw DOM object for the select box
                    select = document.getElementById('section');

                    // Clear the old options
                    select.options.length = 0;

                    // Load the new options
                    $.each(sections, function(index, section) {
                        select.options.add(new Option(section.name, section.id));
                    });
                }
            });
        });

    </g:javascript>
</content>
