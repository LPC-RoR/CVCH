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
	# !!!!!!!!!!!!!!!!!!!!!!! ESTA DEBIERA ELIMINARSE es IGUAL A CARGA_CONTROLLERS
	CARGA_HACIA_CARPETA_CONTROLLERS = ['cargas']
	
	# ---------------------------------------- CONTROL DE DESPLIEGUE --------------------------------------
	# Definir acciones de un controlador como COLECCIONES PROPIAS y OBJETOS PROPIOS
	# evita el proceso registro a registro de algunas condiciones de despliegue
	# En COLECCIONES_PROPIAS hay acciones SHOW porque un SHOW tiene TABLASv que pueden ser PROPIAS
	COLECCIONES_PROPIAS = [
		'publicaciones#index',
		'revisiones#index',
		'equipos#index',
		'areas#index',
		'conceptos#index',
		'carpetas#index',
		'cargas#index',
		'cargas#show'
	]
	OBJETOS_PROPIOS = [
		'cargas#show'
	]
	# ---------------------------------------- DEFAULT --------------------------------------
	# ---------------------------------------- TABLE
	# Se verifica con el helper in_t?(c, label)
	T_DEFAULT = {
		titulo:  {'self' => true,  'show' => false},
		tabs:    {'self' => false, 'show' => false}, 
		estados: {'self' => false, 'show' => false},
		paginas: {'self' => false, 'show' => false},
		nuevo:   {'self' => true,  'show' => false}
	}

	#----------------------------------------- TABLE EXCEPTIONS
	# Estos son los CONTROLADORES que tienen EXCEPCIONES
	# Buscar Modelo::T_EXCEPTIONS
	# USADA SOLO POR in_t? para saber donde buscar Excepciones
	T_E_CONTROLLERS = ['publicaciones', 'equipos', 'carpetas']
	#  EJEMPLO
#	T_EXCEPTIONS = {
#		tabs:    ['self'],
#		paginas: ['*'],
#		nuevo:   ['self', 'contribuciones']
#	}

#	EXCEPTIONS_CONTROLLERS = ['publicaciones', 'textos', 'recursos', 'equipos']
	# EXCEPCIONES en el COMPORTAMIENTO de NEW
	T_E_NEW_CONTROLLERS = ['publicaciones', 'equipos', 'carpetas']
#	T_NEW_EXCEPTIONS = {
#		#'controller' => 'tipo_new'
#		'*' => 'mask',
#		'equipos' => 'inline'
#	}

	# ----------------------------------------- CONTROL DE DESPLIEGUE DE  BOTONES
	# SE USA SOLO PARA CONTROLAR LOS BOTONES DE CADA REGISTRO DE UNA TABLA
	# Buscar MODELO.btns_control. 
	T_E_LINE_BTNS_MODELS = ['Publicacion', 'Carpeta', 'Area'] 

	FORM_CONDITIONAL_FIELDS_MODELS = ['Publicacion']

	# ----------------------------------------- SHOW
	S_DEFAULT = {
		titulo:       true,
		links:        true,
		clasifica:   false,
		detalle:     false,
		inline_form: false,
		tabla:        true,
		adjuntos:    false
	}
	S_E_TITLE_MODELS = ['Publicacion', 'Carga']
	# MODELOS que teiene EXCEPCIONES
	# Buscar Modelo::S_E
	S_E_MODELS = ['Publicacion', 'Texto', 'Equipo']

	# Modelos que tienen STATUS para desplegar en el SHOW
	# Buscar Model::self.status
	S_STATUS_MODELS = ['Carga']

	# -- SHOW : LINKS + NAVEGACION POR CONTEXTO
	# MODELOS QUE TIENEN LINKS
	# 'Carga' tiene el BOTON "Proceso"
	# Busacar en Modelo el Metodo show_links que devuelve una lista de botones
	S_LINKS_MODELS = ['Carga', 'Publicacion']
	# MODELOS que despliegan LINKS para asociaciones BT y HMT
	# Buscar Modelo:: S_BT_OBJECTS
	S_BT_LINKS_MODELS = ['Publicacion']
	# Buscar Modelo::S_HMT_COLLECTIONS
	S_HMT_LINKS_MODELS = ['Publicacion']

	# ---------------------------------------- MENU ------------------------------------------------
	# MENU PRINCIPAL
	MENU = [
		["Colecciones",    "/vistas",            'vistas',         'index'],
		["Escritorio",     "/vistas/escritorio", 'vistas',    'escritorio'],
		["Equipos",        "/equipos",           'equipos',        'index'],
		["Carpetas",       "/carpetas",          'carpetas',       'index'],
		["Areas",          "/areas",             'areas',          'index'],
		["Conceptos",      "/conceptos",         'conceptos',      'index'],
		["Contribuciones", "/contribuciones",    'contribuciones', 'index'],
		["Revisiones",     "/revisiones",        'revisiones',     'index'],
		["Cargas",         "/cargas",            'cargas',         'index'] 
	]

	# CONTROLADORES que NO despliegan el MENU PRINCIPAL
	# Evalualremos la existencia del MENU PRINCIPAL, es posible NO usarlo?
	NOMENU_CONTROLLERS = ['confirmations', 'mailer', 'passwords', 'registrations', 'sessions', 'unlocks']

	# ---------------------------------------- FRAME ------------------------------------------------
	# Controladores con TABS de FRAME
	# Antiguo TABS_CONTROLLERS
	FRAME_CONTROLLERS = ['revisiones', 'recursos']
	# TODOS los MODELOS FRAME TIRNEN EL TITULO EN EL MODELO
	FRAME_CONTROLLERS_WITH_TABS = ['vistas', 'revisiones']

	# --------------------------------------- MODELOS -----------------------------------------------
	# MODELOS que despliegan campos SOLO para PROPIETARIOS del modelo
	# Buscar Modelo::MY_FIELDS
	MODELS_WITH_SELF_FIELDS = ['Equipo']
	# Controladores que tienen HIDDEN CHILDS
	# Buscar Modelo::HIDDEN_CHILDS
	HIDDEN_CHILDS_CONTROLLERS = ['cargas', 'publicaciones', 'textos', 'carpetas', 'investigadores', 'temas', 'equipos', 'areas', 'equipos', 'conceptos', 'instancias']

end
