import grails.databinding.converters.ValueConverter
import org.irblleida.bethax.MyUserDetailsService

beans = {
    userDetailsService(MyUserDetailsService)

    localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
        defaultLocale = new Locale("ca","ES")
        java.util.Locale.setDefault(defaultLocale)
    }

    "defaultGrailsDoubleConverter"(DoubleValueConverter)
    "defaultGrailsFloatConverter"(FloatValueConverter)
}

class DoubleValueConverter implements ValueConverter {
    boolean canConvert(value) { value instanceof Double }
    def convert(value) { return value.replace(',', '.') }
    Class<?> getTargetType() { return Double.class }
}

class FloatValueConverter implements ValueConverter {
    boolean canConvert(value) { value instanceof Float }
    def convert(value) { return value.replace(',', '.') }
    Class<?> getTargetType() { return Float.class }
}