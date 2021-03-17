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

    ## ------------------------------------------------- APARIENCIA APLICACION

    config.look_app = {
        'aplicacion' => {
            favicon: true,
            banner: true,
            nombre: 'CVCh',
            home_link: 'httpg://www.cvch.cl',
            imagen_portada: false,
            titulo_size: '1',
            titulo_color: 'primary',
            detalle_size: '6',
            detalle_color: 'primary',
            foot_size: 'half'
        },
        'navbar' => {
            color: 'info',
            logo: false
        },
        'look_elementos' => {
            'app' => {
                color: 'info'
            },
            'help' => {
                color: 'secondary',
                controllers: ['tema_ayudas', 'tutoriales', 'pasos', 'mensajes', 'observaciones', 'mejoras']
            },
            'data' => {
                color: 'success',
                controllers: ['etapas', 'tablas', 'lineas', 'especificaciones', 'observaciones', 'archivos', 'imagenes']
            }
        }
    }

    ## ------------------------------------------------- MENU

    config.menu = {
#        nomenu_controllers: ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks'],
        nomenu_controllers: [],
        add_contacto: true,
        add_ayuda: true
    }

    ## ------------------------------------------------- TABLA

    config.x.tables.bt_fields = {
        'Modelo' => {
            'field' => ['field_type', 'bt_object']
        },
        'Equipo' => {
            'email' => ['bt_field', 'administrador']
        },
        'Ruta'   => {
            'instancia' => ['bt_field', 'instancia']
        },
        'Propuesta'   => {
            'instancia' => ['bt_field', 'instancia']
        },
    }

    config.x.tables.exceptions = {
        'publicaciones' => {
            elementos: {
                tabs:  ['self', 'contribuciones', 'revisiones'],
                paginas: ['*'],
                nuevo:   ['self', 'contribuciones'],
            },
            tabs: {
                'contribuciones' => ['ingreso', 'contribucion', 'publicada'],
                'revisiones'     => ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera']
            }
        },
        'carpetas'        => {
            elementos: {
                nuevo:    ['vistas']
            }
        },
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
        },
        'conceptos' => {
            elementos: {
                tabs: ['self']
            },
            tabs: ['propios', 'plataforma', 'comunidad']
        },
        'versiones' => {
            elementos: {
                nuevo: ['proyectos']
            }
        },
        'etapas' => {
            elementos: {
                nuevo: ['proyectos']
            }
        },
        'areas' => {
            elementos: {
                titulo: ['rutas'],
                nuevo: ['rutas']
            }
        },
        'administradores' => {
            elementos: {
                titulo: ['recursos'],
                nuevo: ['recursos']
            }
        },
        'categorias' => {
            elementos: {
                titulo: ['rutas'],
                nuevo: ['rutas']
            }
        },
        'especies' => {
            elementos: {
                titulo: ['rutas']
            }
        }
    }

    config.alias_controllers = {
        'papers'         => 'publicaciones',
        'hijos'          => 'conceptos',
        'contribuciones' => 'publicaciones',
        'vistas'         => 'publicaciones',
        'revisiones'     => 'publicaciones'
    }

    config.sortable_tables = {
        'publicaciones' => ['author', 'title', 'doc_type', 'year']
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
                ['Desasignar', '/desasignar', true]
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
                ['Desasignar', '/desasignar', true]
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
        },
        'Ruta'         => {
            conditions: ['x', 'crud'],
            x_btns: [
                ['Eliminar', '/elimina_ruta', true]
            ]
        },
        'Propuesta'         => {
            conditions: ['x', 'crud'],
            x_btns: [
                ['Eliminar', '/elimina_propuesta', true]
            ]
        },
        'Observacion' => {
            conditions: ['crud']
        },
        'Mejora' => {
            conditions: ['crud']
        },
        'TemaAyuda' => {
            conditions: ['crud']
        },
        'Tutorial' => {
            conditions: ['crud']
        },
        'Paso' => {
            conditions: ['crud']
        },
        'Usuario' => {
            conditions: ['crud']
        },
        'Categoria' => {
            conditions: ['crud', 'x'],
            x_btns: [
                ['Desasignar', '/desasignar', true],
                ['Aceptar',    '/aceptar',    true],
                ['Rechazar',   '/rechazar',   true]
            ]
        },
        'Especie' => {
            conditions: ['crud', 'x'],
            x_btns: [
                ['Desasignar', '/desasignar', true],
                ['Aceptar',    '/aceptar',    true],
                ['Rechazar',   '/rechazar',   true]
            ]
        }
    }

    ## ------------------------------------------------- FORM

    config.detail_types_controller = {
        dependencias: ['mejoras', 'mensajes', 'observaciones', 'tema_ayudas', 'tutoriales', 'pasos'],
        modelo: ['publicaciones']
    }

    # estan condiciones se aplican a FORM y SHOW
    config.x.form.exceptions = {
        'Publicacion' => {
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
        },
        'Concepto' => {
            conditional_fields: [
                'administracion'
            ]
        },
        'Mensaje' => {
            conditional_fields: ['email']
        },
        'Categoria' => {
            conditional_fields: ['base']
        }
    }

    ## ------------------------------------------------- SHOW

    config.x.show.exceptions = {
        'Publicacion' => {
            elementos: [:clasifica, :detalle, :tabla, 'show_title'],
        },
        'Equipo'     => {
            elementos: [:detalle, :inline_form, :status]
        },
        'Carga' => {
            elementos: [:status]
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

  end
end
