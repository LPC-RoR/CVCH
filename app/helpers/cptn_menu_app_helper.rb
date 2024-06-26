module CptnMenuAppHelper

	def menu_base
	    [
	        ['',           '/tablas', 'admin', 'person-rolodex'],
#	        ["Contenido",  "/tema_ayudas",                 'admin', 'stack'],
	        ["Procesos",   "/app_recursos/procesos",       'dog',   'radioactive']
	    ]
	end

	def menu
	    ## Menu principal de la aplicación
	    # [ 'Item del menú', 'link', 'accesso', 'gly' ]
	    [
#	        [nil,              "/vistas/graficos",    'general', 'bar-chart-line'],
	        ["Colecciones",    "/vistas",             'anonimo', 'book'],
	        ["Contribuciones", "/contribuciones",     'general', 'file-earmark-arrow-up'],
	        ['Taxonomía',      "/publicos/taxonomia", 'anonimo',   'diagram-3'],
	        ["Revisiones",     "/revisiones",         'admin',   'file-check'],
#	        ["Cargas",         "/cargas",             'admin',   'upload'],
	        [nil,              "/ind_estructuras",    'dog',     'binoculars'],
	        [nil,              "/blg_articulos",      'nomina',  controller_icon['blg_articulos'], 'Blogs'],
	        [nil,              "/publicos/huerfanas", 'anonimo',   'tag', 'Etiquetas por clasificar'],
	        [nil,              "/filo_elementos", 'dog',   'diagram-3', 'Elementos']
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

end