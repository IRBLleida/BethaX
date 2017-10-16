package org.irblleida.bethax

class BethaXTagLib {
    static namespace = "bx"
    static defaultEncodeAs = [taglib: 'raw']
    static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    /**
     * Renders a form field from a domain class.
     *
     * @attr bean REQUIRED the domain class instance
     * @attr property REQUIRED the property name of the domain class
     * @attr type the property type: 'text' (default), 'textarea', 'number', 'select', 'date', 'switch'
     *
     * //TODO: Add documentation
     */
    def showField = { attrs, body ->
        attrs.enum = attrs.enum ?: null
        if(attrs.enum && attrs.value) attrs.value = g.message(code: 'enum.' + attrs.enum + '.value.' + attrs.value)
        attrs.name = attrs.property
        if(attrs.width == null) attrs.width = 3

        if(!attrs.type) {
            switch (attrs.bean.getClass().getDeclaredField(attrs.name)?.type) {
                case(java.lang.String):
                    attrs.type = 'text'
                    break
                case(java.lang.Boolean):
                    attrs.type = 'select'
                    if(attrs.prefix == null) attrs.prefix = 'default.yesno'
                    break
                case(org.irblleida.bethax.Person):
                    attrs.type = 'select'
                    break
            }
        }

        attrs.domain = attrs.bean.getClass().getSimpleName().toLowerCase()
        attrs.rawValue = attrs.bean[attrs.property]
        attrs.value = attrs.bean ? (attrs.bean[attrs.name] ?: '<i class="fa fa-minus red" aria-hidden="true"></i>') : (attrs.value ?: '<i class="fa fa-minus red" aria-hidden="true"></i>')
        attrs.offset = attrs.offset ? 'col-md-offset-' + attrs.offset : ''
        attrs.pre = attrs.pre ?: false

        out << g.render(template: "/taglibTemplates/showField", model: attrs)
    }

    /**
     * Renders a form field from a domain class.
     *
     * @attr bean REQUIRED the domain class name
     * @attr property REQUIRED the property name of the domain class
     * @attr type the property type: 'text' (default), 'textarea', 'number', 'select', 'date', 'switch'
     *
     * //TODO: Add documentation
     */
    def formField = { attrs, body ->
        attrs.required = attrs.required ?: false
        attrs.prefix = attrs.prefix ?: null
        attrs.domain = attrs.bean.getClass().getSimpleName().toLowerCase()
        attrs.name = attrs.property
        attrs.value = attrs.value ?: attrs.bean[attrs.property]
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

        def type = attrs.type ?: 'text'

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
