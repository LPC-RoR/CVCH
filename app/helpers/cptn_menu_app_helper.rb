module CptnMenuAppHelper

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
	        [nil,              "/vistas/graficos",   'general', 'bar-chart-line'],
	        ["Colecciones",    "/vistas",            'anonimo', 'book'],
	        ["Carpetas",       "/carpetas",          'nomina',  'folder'],
	        ["Contribuciones", "/contribuciones",    'general', 'file-earmark-arrow-up'],
	        ['Especies',       "/especies",          'admin',   'bug'],
	        ["Revisiones",     "/revisiones",        'admin',   'file-check'],
	        ["Cargas",         "/cargas",            'admin',   'upload'],
	        [nil,              "/ind_estructuras",   'dog',     'binoculars'],
	        [nil,       "/blg_articulos",             'nomina', controller_icon['blg_articulos'], 'Blogs']
	    ]

	end

	def dd_items(item)
		case item
		when 'Valores'
			[
				['Tarifas Base', '/tar_tarifas'],
				['Facturas', 'tar_facturas']
			]
		when 'Documentos'
			[
				['Compartidos', '/app_repos/publico'],
				['Personales', '/app_repos/perfil']
			]
		when 'Enlaces'
			[
			]
		end
	end

	def display_item_app(item, tipo_item)
		true
	end

end