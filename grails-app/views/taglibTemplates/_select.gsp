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
        </label>
        <g:if test="${required != false && noSelection != null}">
            <g:select name="${name}" from="${from}" optionKey="${optionKey}" optionValue="${optionValue}" noSelection="${noSelection}" value="${value}" required="required" class="form-control ${inputClass}" valueMessagePrefix="${prefix}" />
        </g:if>
        <g:elseif test="${required != false && noSelection == null}">
            <g:select name="${name}" from="${from}" optionKey="${optionKey}" optionValue="${optionValue}" value="${value}" required="required" class="form-control ${inputClass}" valueMessagePrefix="${prefix}" />
        </g:elseif>
        <g:elseif test="${required == false && noSelection != null}">
            <g:select name="${name}" from="${from}" optionKey="${optionKey}" optionValue="${optionValue}" noSelection="${noSelection}" value="${value}" class="form-control ${inputClass}" valueMessagePrefix="${prefix}" />
        </g:elseif>
        <g:else>
            <g:select name="${name}" from="${from}" optionKey="${optionKey}" optionValue="${optionValue}" value="${value}" class="form-control ${inputClass}" valueMessagePrefix="${prefix}" />
        </g:else>
    </div>
</div>
