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
	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['investigador', 'normal'],
		['sha1',         'normal']
	]

	S_E = [:detalle]
	F_TABLA = 'administrador'

	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	HIDDEN_CHILDS = ['publicaciones', 'integrantes']

	belongs_to :administrador, class_name: 'Investigador'

	has_many :publicaciones
	has_many :carpetas

	has_many :integrantes
	has_many :investigadores, through: :integrantes
end
