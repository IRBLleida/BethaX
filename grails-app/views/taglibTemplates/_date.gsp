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
        <div class="input-group date">
            <input type="text" name="${name}" value="${value ? value.format('dd/MM/yyyy') : ''}" class="form-control" id="${name}" placeholder="dd/mm/aaaa" ${required != false ? 'required="required"' : ''} />
            <span class="input-group-addon"><i class="fa fa-calendar" aria-hidden="true"></i></span>
        </div>
    </div>
</div>
