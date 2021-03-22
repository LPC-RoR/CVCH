# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )

    # palabras terminadas en 'or' {'investigador', 'autor'} y en 'en' {origen}
    inflect.plural /(.[eo][rn])$/i, '\1es'
    inflect.singular /(.[eo][rn])es/i, '\1'

    # palabras terminadas en 'a', no agregue las otras vocales porque no hay problema
    inflect.plural /(a)$/i, '\1s'

    # palabras terminadas en 'e', no agregue las otras vocales porque no hay problema
    inflect.singular /(e)s$/i, '\1'

    # palabras terminadas en 'r'
    inflect.plural /(r)$/i, '\1es'
    inflect.singular /(r)es/i, '\1'

    # palabras terminadas en 'cion' y 'sion'
    inflect.plural /(ion)$/i, '\1es'
    inflect.singular /(ion)es/i, '\1'

    # palabras terminadas en 'cion' y 'sion'
    inflect.plural /(l)$/i, '\1es'
    inflect.singular /(l)es/i, '\1'

    inflect.plural 'imagen', 'imagenes'
    inflect.plural 'Imagen', 'Imagenes'
    inflect.singular 'imagenes', 'imagen'
    inflect.singular 'Imagenes', 'Imagen'

end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
