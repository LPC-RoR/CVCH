class Equipo < ApplicationRecord
	# TABS DEL TABLE
	TABS = ['Administrados', 'Participaciones']

	HIDDEN_CHILDS = ['integrantes']

	# ------------------------------------------------- TABLA
	T_EXCEPTIONS = {
		tabs:    ['self']
	}

	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'*' => 'inline',
	}

	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['Eliminar', '/equipos/', '/elimina_equipo', true]
	]

	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['email',   'normal'],
		['sha1',    'normal']
	]

	S_E = [:detalle]
	F_TABLA = 'perfil'

 	FORM_FIELDS = [
		['equipo',             'entry'],
		['perfil_id',         'hidden'],
	]
	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	HIDDEN_CHILDS = ['publicaciones', 'integrantes']

	belongs_to :administrador, class_name: 'Perfil'

	has_one :perfil

	has_many :publicaciones
	has_many :carpetas

	has_many :integrantes
	has_many :perfiles, through: :integrantes
end
