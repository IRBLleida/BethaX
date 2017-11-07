<div class="col-md-${width}${cssClass ? ' ' + cssClass : ''} ${offset}">
    <div class="form-group">
        <label for="${name}">
            <g:if test="${message(code: domain + '.' + name + '.abbr', default: '') != ''}">
                <abbr title="${message(code: domain + '.' + name + '.label')}">
                    <g:message code="${domain + '.' + name + '.abbr'}" />
                </abbr>
            </g:if>
            <g:else>
                <g:message code="${domain + '.' + name + '.label'}" />
            </g:else>
            <g:if test="${required != false}">
                <span class="red">*</span>
            </g:if>
            <%--
            <i class="fa fa-tags" aria-hidden="true"></i>
            --%>
        </label>
        <g:if test="${addon != null}">
            <div class="input-group">
        </g:if>
        <%-- applyCode prevents double quotes to be rendered as &quot; inside the groovy code (this part: 'min="') --%>
        <%-- Another workaround is to use it as the "max" attribute --%>
        <%-- More here: http://aruizca.com/how-to-render-json-properly-without-escaping-quotes-inside-a-gsp-script-tag/ --%>
        <g:applyCodec encodeAs="none">
        <input type="number" step="${step}" ${min ? 'min="' + min + '"' : ''} max="${max ? max : ''}" name="${name}" value="${value}" class="form-control" id="${name}" placeholder="${message(code: domain + '.' + name + '.placeholder', default: message(code: domain + '.' + name + '.label'))}" />
        </g:applyCodec>
        <g:if test="${addon != null}">
            <div class="input-group-addon">${raw(addon)}</div>
            </div>
        </g:if>
        <g:if test="${help}">
            <p class="help-block">${help}</p>
        </g:if>
        <g:if test="${helpText}">
            <small class="form-text text-info">
                <i class="fa fa-arrow-right" aria-hidden="true"></i>
                ${helpText}
            </small>
        </g:if>
    </div>
</div>
