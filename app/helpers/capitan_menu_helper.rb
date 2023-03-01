module CapitanMenuHelper

	def optional_menu_item
		{
			contacto: true,
			ayuda: true,
		}
	end

	def menu_base
	    [
	        ['',           '/app_recursos/administracion', 'admin', 'person-rolodex'],
	        ["Contenido",  "/tema_ayudas",                 'admin', 'stack'],
	        ["Procesos",   "/app_recursos/procesos",       'dog',   'radioactive']
	    ]
	end

	def menu
	    ## Menu principal de la aplicación
	    # [ 'Item del menú', 'link', 'accesso', 'gly' ]
	    [
	        ['',               "/vistas/graficos",   'general', 'bar-chart-line'],
	        ["Colecciones",    "/vistas",            'anonimo', 'newspaper'],
	        ["Escritorio",     "/vistas/escritorio", 'general', 'window-sidebar'],
	        ["",               "/equipos",           'general', 'people'],
	        ["Contribuciones", "/contribuciones",    'general', 'file-earmark-arrow-up'],
	        ['',               "/especies",          'general', 'bug'],
	        ["Revisiones",     "/revisiones",        'admin',   'file-check'],
	        ["Cargas",         "/cargas",            'admin',   'upload'],
	        ["",               "/ind_estructuras",   'dog',     'binoculars'] 
	    ]

	end

	def dd_items(item)
		case item
		when 'Investigación'
			[
#				['Líneas de Investigación', root_path],
#				['Premios y Honores', root_path]
			]
		end
	end

	def display_item_app(item, tipo_item)
		true
	end

end