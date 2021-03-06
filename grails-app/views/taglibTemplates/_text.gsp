<div class="col-md-${width}">
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
        </label>
        <g:if test="${addon != null}">
            <div class="input-group">
        </g:if>
        <input type="text" name="${name}" value="${value}" class="form-control" id="${name}" placeholder="${message(code: domain + '.' + name + '.label')}" ${required ? 'required=required' : ''} ${maxlength ? 'maxlength=' + maxlength : ''} />
        <g:if test="${addon != null}">
            <div class="input-group-addon">${addon}</div>
            </div>
        </g:if>
        <g:if test="${helpText}">
            <small class="form-text text-info">
                <i class="fa fa-arrow-right" aria-hidden="true"></i>
                ${helpText}
            </small>
        </g:if>
    </div>
</div>
