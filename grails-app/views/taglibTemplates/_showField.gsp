<div class="col-md-${width} ${offset}">
    <dl class="animated fadeIn">
        <dt>
            <g:if test="${message(code: domain + '.' + name + '.abbr', default: '') != ''}">
                <abbr title="${message(code: domain + '.' + name + '.label')}">
                    <g:message code="${domain + '.' + name + '.abbr'}" />
                </abbr>
            </g:if>
            <g:else>
                <g:message code="${domain}.${name}.label" />
            </g:else>
        </dt>
        <dd class="sliding-middle-out ${cssClass}">
            <g:if test="${pre}"><pre>${raw(value)}</pre></g:if>
            <g:else>
                <g:if test="${type == 'text'}">
                    ${raw(value)} ${addon}
                </g:if>
                <g:elseif test="${type == 'number'}">
                    <g:if test="${rawValue != null && rawValue instanceof Number}">
                        <g:formatNumber number="${rawValue}" maxFractionDigits="2" />
                        <g:if test="${addon != null}">
                            ${raw(addon)}
                        </g:if>
                    </g:if>
                    <g:else>
                        ${raw(value)}
                    </g:else>
                </g:elseif>
                <g:elseif test="${type == 'date'}">
                    <g:if test="${value instanceof Date}">
                        <g:formatDate date="${value}" format="dd/MM/yyyy" />
                    </g:if>
                    <g:else>${raw(value)}</g:else>
                </g:elseif>
                <g:elseif test="${type == 'time'}">
                    <g:if test="${value instanceof Date}">
                        <g:formatDate date="${value}" format="HH:mm" />
                    </g:if>
                    <g:else>${raw(value)}</g:else>
                </g:elseif>
                <g:elseif test="${type == 'datetime'}">
                    <g:if test="${value instanceof Date}">
                        <g:formatDate date="${value}" format="dd/MM/yyyy HH:mm" />
                    </g:if>
                    <g:else>${raw(value)}</g:else>
                </g:elseif>
                <g:elseif test="${type == 'select'}">
                    <g:if test="${prefix}">
                        <g:if test="${rawValue != null}">
                            <g:message code="${prefix}.${rawValue}" />
                        </g:if>
                        <g:else>
                            ${raw(value)}
                        </g:else>
                    </g:if>
                    <g:else>
                        <g:if test="${link}">
                            <g:link controller="${link}" action="show" id="${value.id}">
                                ${raw(value)}
                            </g:link>
                        </g:if>
                        <g:else>
                            ${raw(value)}
                        </g:else>
                    </g:else>
                </g:elseif>
            </g:else>
        </dd>
    </dl>
</div>
