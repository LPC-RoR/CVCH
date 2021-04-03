require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cvch
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # +++ HCH activa locala :es
    config.i18n.default_locale = :es

    ## ------------------------------------------------- 0p
    ## ------------------------------------------------- STANDARD

    ## comportamiento por defecto de los elementos de una tabla
    # Se verifica con el helper in_t?(c, label)
    config.t_default = {
        titulo:  {'self' => true,  'show' => false},
        tabs:    {'self' => false, 'show' => false}, 
        estados: {'self' => false, 'show' => false},
        paginas: {'self' => false, 'show' => false},
        nuevo:   {'self' => true,  'show' => false}
    }

    # Se verifica con el helper in_show?(c, label)
    config.s_default = {
        titulo:       true,
        links:        true,
        clasifica:   false,
        detalle:     false,
        inline_form: false,
        tabla:        true,
        adjuntos:    false
    }

    config.look_parameters = {
        image_sizes: ['entire', 'half', 'quarter', 'thumb'],
        colors: ['primary', 'secondary', 'success', 'danger', 'warning', 'info', 'light', 'dark', 'muted', 'white']
    }

    ## ------------------------------------------------- APARIENCIA APLICACION

    config.look_app = {
        aplicacion: {
            favicon: true,
            banner: true,
            nombre_aplicacion: 'CVCh',
            home_link: 'http://www.cvch.cl',
            portada: {
                active: true,
                size: nil,
                clase: 'mx-auto d-block'
            },
            init: {
                size: 'half',
                clase: 'mx-auto d-block',
                titulo_size: 1,
                titulo_color: 'info',
                detalle_size: 6,
                detalle_color: 'info'
            },
            foot: {
                active: true,
                size: 'half',
                clase: 'mx-auto d-block'
            },
            help: {
                size: 'quarter',
                clase: 'mx-auto d-block'
            }
        },
        navbar: {
            color: 'info',
            logo: false,
            nomenu_controllers: [],
            item_contacto: true,
            item_ayuda: true
        },
        look_elementos: {
            app: {
                color: 'info'
            },
            help: {
                color: 'secondary',
                controllers: ['tema_ayudas', 'tutoriales', 'pasos', 'mensajes']
            },
            data: {
                color: 'success',
                controllers: ['etapas', 'tablas', 'lineas', 'especificaciones', 'observaciones', 'archivos', 'imagenes']
            }
        }
    }

    ## ------------------------------------------------- TABLA

    config.tables = {
        exceptions: {
            titulo: {
                'areas' => ['rutas'],
                'administradores' => ['recursos'],
                'categorias' => ['rutas'],
                'especies' => ['rutas']
            },
            estados: {},
            tabs: {
                'publicaciones' => ['contribuciones', 'revisiones'],
                'equipos' => ['self'],
                'conceptos' => ['self']
            },
            paginas: {
                'publicaciones' => ['*']
            },
            nuevo: {
                'publicaciones' => ['self', 'contribuciones'],
                'carpetas' => ['vistas'],
                'versiones' => ['proyectos'],
                'etapas' => ['proyectos'],
                'areas' => ['rutas'],
                'administradores' => ['recursos'],
                'categorias' => ['rutas']
            },
            inline_form: {
                'equipos' => ['*']
            }
        },
        tabs: {
            'publicaciones' => {
                'contribuciones' => ['ingreso', 'contribucion', 'publicada'],
                'revisiones'     => ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera']
            },
            'equipos' => {
                'equipos' => ['Administrados', 'Participaciones']
            },
            'conceptos' => {
                'conceptos' => ['propios', 'plataforma', 'comunidad']
            }
        },
        bt_fields: {
            'Equipo' => {
                'email' => 'administrador'
            },
            'Ruta' => {
                'instancia' => 'instancia'
            },
            'Propuesta' => {
                'instancia' => 'instancia'
            }
        },
        alias: {
            'papers' => 'publicaciones',
            'hijos' => 'conceptos',
            'contribuciones' => 'publicaciones',
            'vistas' => 'publicaciones',
            'revisiones' => 'publicaciones'
        },
        sortable: {
            'publicaciones' => ['author', 'title', 'doc_type', 'year']
        }
    }

    ## ------------------------------------------------- FORM

    config.form = {
        conditional_fields: {
            'Publicacion' => [
                'd_quote',
                'm_quote',
                'd_author',
                'title',
                'author',
                'd_journal',
                'journal',
                'year',
                'volume',
                'pages',
                'd_doi',
                'doi',
                'abstract',
                'book',
                'editor',
                'academic_degree',
                'ciudad_pais'
            ],
            'Mensaje' => ['email'],
            'Concepto' => ['administracion'],
            'Categoria' => ['base']
        }
    }

    ## ------------------------------------------------- SHOW

    config.show = {
        titulo: [],
        show_title: ['Publicacion'],
        partial_links: [],
        detalle: ['Publicacion', 'Equipo'],
        inline_form: ['Equipo'],
        tabla: ['Publicacion'],
        links: ['Publicacion'],
        bt_links: {
            'Publicacion' => ['revista']
        },
        hmt_links: {
            'Publicacion' => ['investigadores']
        },
        status: ['Equipo', 'Carga'],
        hidden: {
            'publicaciones'  => ['autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones', 'asignaciones', 'areas', 'rutas', 'instancias', 'etiquetas'],
            'carpetas'       => ['clasificaciones', 'herencias'],
            'investigadores' => ['autores', 'carpetas'],
            'equipos'        => ['investigadores', 'instancias', 'integrantes', 'herencias'],
            'areas'          => ['clasificaciones', 'cargas'],
            'conceptos'      => ['rel_hijos', 'hijos', 'diccionarios'],
            'instancias'     => ['rutas', 'diccionarios', 'propuestas'],
            'categorias'     => ['etiquetas', 'suscripciones', 'perfiles'],
            'especies'       => ['etiquetas']
        }
    }

  end
end
