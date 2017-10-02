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
        <div class="input-group">
            <input type="text" name="${name}" value="${value ? value.format('HH:mm') : ''}" class="form-control timepicker" id="${name}" placeholder="HH:MM" ${required != false ? 'required="required"' : ''} />
        </div>
    </div>
</div>
