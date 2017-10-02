package org.irblleida.bethax

class BethaXTagLib {
    static namespace = "bx"
    static defaultEncodeAs = [taglib: 'raw']
    static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def showField = { attrs, body ->
        attrs.enum = attrs.enum ?: null
        if(attrs.enum && attrs.value) attrs.value = g.message(code: 'enum.' + attrs.enum + '.value.' + attrs.value)

        attrs.domain = attrs.domain ? attrs.domain : 'patient'
        attrs.type = attrs.type ?: 'text'
        attrs.rawValue = attrs.value
        attrs.value = attrs.value ?: '<i class="fa fa-minus red" aria-hidden="true"></i>'
        attrs.offset = attrs.offset ? 'col-md-offset-' + attrs.offset : ''
        attrs.pre = attrs.pre ?: false

        out << g.render(template: "/taglibTemplates/showField", model: attrs)
    }

    /**
     * Renders a form field from a domain class.
     *
     * @attr domain REQUIRED the domain class name
     * @attr name REQUIRED the property name of the domain class
     * @attr type the property type: 'text' (default), 'textarea', 'number', 'select', 'date', 'switch'
     *
     * //TODO: Add documentation
     */
    def formField = { attrs, body ->
        attrs.required = attrs.required ?: false
        attrs.prefix = attrs.prefix ?: null
        attrs.domain = attrs.domain ? attrs.domain : 'patient'
        attrs.type = attrs.type ?: 'text'
        if(attrs.type == 'select') {
            if(attrs.value == null) attrs.value = ''
        }
        else {
            if(attrs.value != 0) attrs.value = attrs.value ?: ''
        }

        attrs.required = attrs.required ?: false
        attrs.offset = attrs.offset ? 'col-md-offset-' + attrs.offset : ''
        attrs.addon = attrs.addon ?: null
        attrs.rows = attrs.rows ?: 2
        attrs.cssClass = attrs.cssClass ?: ''
        attrs.tooltip = attrs.tooltip ?: null
        attrs.step = attrs.step ?: 'any'

        def domain = attrs.domain ? attrs.domain : 'patient'
        def name = attrs.name
        def type = attrs.type ?: 'text'
        def value = attrs.value ?: ''
        def width = attrs.width
        def required = attrs.required ?: false
        def offset = attrs.offset ? 'col-md-offset-' + attrs.offset : ''
        def from = attrs.from ?: null
        def optionKey = attrs.optionKey ?: 'id'
        def optionValue = attrs.optionValue ?: 'name'
        def noSelection = attrs.noSelection ?: null
        def enumName = attrs.enum ?: null
        def addon = attrs.addon ?: null
        def step = attrs.step ?: 'any'
        def min = attrs.min ?: null
        def max = attrs.max ?: null


        if(type == 'text') {
            out << g.render(template: "/taglibTemplates/text", model: attrs)
        }
        if(type == 'textarea') {
            out << g.render(template: "/taglibTemplates/textarea", model: attrs)
        }
        else if(type == 'number') {
            out << g.render(template: "/taglibTemplates/number", model: attrs)
        }
        else if(type == 'select') {
            out << g.render(template: "/taglibTemplates/select", model: attrs)
        }
        else if(type == 'date') {
            out << g.render(template: "/taglibTemplates/date", model: attrs)
        }
        else if(type == 'time') {
            out << g.render(template: "/taglibTemplates/time", model: attrs)
        }
    }
}
