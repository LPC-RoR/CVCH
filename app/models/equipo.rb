class Equipo < ApplicationRecord
	# TABS DEL TABLE
	TABS = ['Administrados', 'Participaciones']

	HIDDEN_CHILDS = ['integrantes']

	# ------------------------------------------------- TABLA
	TABLE_EXCEPTIONS = {
		tabs:    {'self' => true}
	}

	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['investigador', 'normal'],
		['sha1',         'normal']
	]

	SHOW_EXCEPTIONS = [:detalle]
	F_TABLA = 'administrador'

	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	belongs_to :administrador, class_name: 'Investigador'

	has_many :publicaciones
	has_many :carpetas

	has_many :integrantes
	has_many :investigadores, through: :integrantes
end
