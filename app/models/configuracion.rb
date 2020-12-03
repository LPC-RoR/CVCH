class Configuracion < ApplicationRecord
	# ---------------------------------------- CARGA ------------------------------------------------
	# Esta Constante debiera estar en el Modelo CARGA !!
	# Este es una constante que uso mientras no hay manejo de USUARIOS
	# -----------------------------------------TEMPORAL ------------------------------------------
	RUTA_ARCHIVOS= {
		'cargas' => "/home/hugo/cvch/archivos/admin/cargas/"
	}

	# Controladores que tienen rutinas de Carga
	# Esta constante se usa para crear los directorios por USUARIO
	# Pendiente queda un helper o método en application_controller
	# NO USADO AUN
	CARGA_CONTROLLERS = ['cargas']
	# Estos controladores ponen la carga en una carpeta.
	# Buscar en el MODELO la constante Modelo::CARPETA_CARGA para seber cual
	# NO USADO AUN
	CARGA_HACIA_CARPETA_CONTROLLERS = ['cargas']
	
	# ---------------------------------------- DEFAULT -----------------------------------------------
	COLECCIONES_PROPIAS = [
		'publicaciones#index',
		'revisiones#index',
		'equipos#index',
		'areas#index',
		'carpetas#index',
		'cargas#index',
		'cargas#show',
		'carpetas#show'
	]
	OBJETOS_PROPIOS = [
		'carpetas#show',
		'temas#show',
		'cargas#show'
	]
	# Buscar self.btns_control
	BTNS_CONTROL_MODELS = ['Publicacion', 'Carpeta', 'Area']
	# ---------------------------------------- TABLE
	D_TABLA = {
		titulo:  {'self' => true,  'show' => false},
		tabs:    {'self' => false, 'show' => false}, 
		estados: {'self' => false, 'show' => false},
		paginas: {'self' => false, 'show' => false},
		nuevo:   {'self' => true,  'show' => false}
	}
	# Estos son los CONTROLADORES que tienen EXCEPCIONES
	# Buscar Modelo::TABLE_EXCEPTIONS
	EXCEPTIONS_CONTROLLERS = ['publicaciones', 'textos', 'recursos', 'equipos']
	# EXCEPCIONES en el COMPORTAMIENTO de NEW
	EXCEPTIONS_NEW_CONTROLLERS = {
		#'controller' => 'tipo_new'
		'publicaciones' => 'mask',
		'equipos' => 'inline_form'
	}

	FORM_CONDITIONAL_FIELDS_MODELS = ['Publicacion']

	# ----------------------------------------- SHOW
	D_SHOW = {
		titulo:       true,
		links:        true,
		clasifica:   false,
		detalle:     false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}
	# MODELOS que teiene EXCEPCIONES
	# Buscar Modelo::SHOW_EXCEPTIONS
	EXCEPTIONS_MODELS = ['Publicacion', 'Texto', 'Equipo']

	# ---------------------------------------- MENU ------------------------------------------------
	# MENU PRINCIPAL
	MENU = [
		["Colecciones",             "/vistas"],
		["Escritorio",   "/vistas/escritorio"],
		["Equipos",                "/equipos"],
		["Carpetas",              "/carpetas"],
		["Areas",                    "/areas"],
		["Contribuciones",  "/contribuciones"],
		["Revisiones",          "/revisiones"],
		["Cargas",                  "/cargas"] 
	]

	# CONTROLADORES que NO despliegan el MENU PRINCIPAL
	# Evalualremos la existencia del MENU PRINCIPAL, es posible NO usarlo?
	NOMENU_CONTROLLERS = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']

	# ---------------------------------------- FRAME ------------------------------------------------
	# Controladores con TABS de FRAME
	# Antiguo TABS_CONTROLLERS
	FRAME_CONTROLLERS = ['revisiones', 'recursos']
	# TODOS los MODELOS FRAME TIRNEN EL TITULO EN EL MODELO
	FRAME_CONTROLLERS_WITH_TABS = ['vistas']

	# --------------------------------------- MODELOS -----------------------------------------------
	# MODELOS que despliegan campos SOLO para PROPIETARIOS del modelo
	# Buscar Modelo::MY_FIELDS
	MODELS_WITH_SELF_FIELDS = ['Equipo']
	# Controladores que tienen HIDDEN CHILDS
	# Buscar Modelo::HIDDEN_CHILDS
	HIDDEN_CHILDS_CONTROLLERS = ['cargas', 'publicaciones', 'textos', 'carpetas', 'investigadores', 'temas', 'equipos', 'areas']

	# --------------------------------------- NAVEGACION POR CONTEXTO
	# MODELOS QUE TIENEN LINKS
	# 'Carga' tiene el BOTON "Proceso"
	# Busacar en Modelo el Metodo show_links que devuelve una lista de botones
	SHOW_LINKS_MODELS = ['Carga', 'Publicacion']
	# MODELOS que despliegan LINKS para asociaciones BT y HMT
	# Buscar Modelo:: SHOW_BT_OBJECTS
	SHOW_BT_LINKS_MODELS = ['Publicacion']
	# Buscar Modelo::SHOW_HMT_COLLECTIONS
	SHOW_HMT_LINKS_MODELS = ['Publicacion', 'Texto']

end
