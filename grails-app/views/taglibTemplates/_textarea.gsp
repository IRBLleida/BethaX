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
            <%--
            <i class="fa fa-tags" aria-hidden="true"></i>
            --%>
        </label>
        <g:if test="${addon != null}">
            <div class="input-group">
        </g:if>
        <g:textArea name="${name}" value="${value}" class="form-control" placeholder="${g.message(code: domain + '.' + name + '.label')}" rows="${rows}" maxlength="${maxlength}"  />
        <g:if test="${addon != null}">
            <div class="input-group-addon">${raw(addon)}</div>
            </div>
        </g:if>
    </div>
</div>
