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


    ## ------------------------------------------------- CAPITAN

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
    ## ------------------------------------------------- MENU
    # controladores que NO despliegan MENU
    # se usa en nomenu?
    config.x.menu.exceptions_controllers = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']    

    ## Menu principal de la aplicación
    # [0] : Item del menú
    # [1] : Link del ítem
    # [2] : Tipo de ítem {'admin', 'usuario', 'anonimo', 'excluir'}
    # se usa directamente en 0p/navbar/_navbar.html.erb

    config.menu = [
        ["Gráficos",       "/vistas/graficos",   'usuario'],
        ["Colecciones",    "/vistas",            'anonimo'],
        ["Escritorio",     "/vistas/escritorio", 'usuario'],
        ["Contribuciones", "/contribuciones",    'usuario'],
        ["Equipos",        "/equipos",           'usuario'],
        ["Carpetas",       "/carpetas",          'usuario'],
        ["Administradores","/administradores",   'admin'],
        ["Areas",          "/areas",             'admin'],
        ["Conceptos",      "/conceptos",         'admin'],
        ["Revisiones",     "/revisiones",        'admin'],
        ["Cargas",         "/cargas",            'admin'] 
    ]

    ## ------------------------------------------------- FRAMES
    config.frames = {
        'vistas' => {
            'index' => {
                titulo: 'Colecciones',
                selector: 'Áreas',
                tabs: ['Completa', 'Pendiente'],
                action_type: 'tabla'
            },
            'escritorio' => {
                titulo: 'Escritorio',
                selector: 'Carpetas',
                action_type: 'tabla'
            }

        },
        'revisiones' => {
            'index' => {
                titulo: 'Revisión de Citas',
                selector: 'Áreas',
                tabs: ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera'],
                action_type: 'tabla'
            }
        },
        'contribuciones' => {
            'index' => {
                titulo: 'Contribución de Citas',
                action_type: 'tabla'
            }
        }
    }

    ## ------------------------------------------------- TABLA

    config.x.tables.bt_fields = {
        'Modelo' => {
            'field' => ['field_type', 'bt_object']
        },
        'Equipo' => {
            'email' => ['bt_field', 'administrador']
        }
    }

    config.x.tables.exceptions = {
        'publicaciones' => {
            elementos: {
                tabs:  ['self', 'contribuciones'],
                paginas: ['*'],
                nuevo:   ['self', 'contribuciones'],
            },
            tabs: ['ingreso', 'contribucion', 'publicada']
        },
#        'carpetas'        => {
#            elementos: {
#                nuevo:    ['equipos']
#            }
#        },
        'equipos'     => {
            elementos: {
                tabs:    ['self']
            },
            tabs: ['Administrados', 'Participaciones'],
            new_type: {
                #'controller' => 'tipo_new'
                # '*' en todo controller_name
                '*' => 'inline'
            }
        }
    }

    ## ------------------------------------------------- TABLA | BTNS

    ## x_btns
    # [0] : Nombre del boton
    # [1] : link base, a esta base se le agrega el instancia_id
    # [2] : Si es true se agrega "objeto_id=#{@objeto.id}"

    config.x.btns.exceptions = {
        'Publicacion'   => {
            conditions: ['crud']
        },
        'Carpeta'       => {
            conditions: ['crud', 'x'],
            x_btns: [
                ['Eliminar', '/elimina_carpeta', true]
            ]
        },
        'Carga'         => {
            conditions: ['x', 'crud'],
            x_btns: [   
                ['Proceso', '/procesa_carga', false]
            ]
        },
        'Area'         => {
            conditions: ['crud', 'x'],
            x_btns: [
                ['Eliminar', '/elimina_area', true]
            ]
        },
        'Equipo'       => {
            x_btns: [
                ['Eliminar', '/elimina_equipo', true]
            ]
        },
        'Instancia'    => {
            conditions: ['x', 'crud'],
            x_btns: [
                ['Eliminar', '/elimina_instancia', true]
            ]
        }
    }

    ## ------------------------------------------------- FORM

    # estan condiciones se aplican a FORM y SHOW
    config.x.form.exceptions = {
        'Publicacion' => {
            f_detail: true,
            conditional_fields: [
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
            ]
        }
    }

    ## ------------------------------------------------- SHOW

    config.x.show.exceptions = {
        'Publicacion' => {
            elementos: [:clasifica, :detalle, :tabla, 'show_title'],
        },
        'Equipo'     => {
            elementos: [:detalle, :inline_form]
        }
    }

    config.x.show.links = {
        links:     ['Publicacion'],
        bt_links:  ['Publicacion'],
        hmt_links: ['Publicacion'],
        bt_objects: {
            'Publicacion' => ['revista']
        },
        hmt_collections: {
            'Publicacion' => ['investigadores']
        }
    }


    config.x.show.hidden = {
        'publicaciones'  => ['autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones', 'asignaciones', 'areas', 'rutas', 'instancias'],
        'carpetas'       => ['clasificaciones', 'herencias'],
        'investigadores' => ['autores', 'carpetas'],
        'equipos'        => ['investigadores', 'instancias', 'integrantes', 'herencias'],
        'areas'          => ['clasificaciones', 'cargas'],
        'conceptos'      => ['rel_hijos'],
        'instancias'     => ['rutas']
    }

  end
end
