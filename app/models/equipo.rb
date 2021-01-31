class Equipo < ApplicationRecord
	# TABS DEL TABLE
	# ------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['equipo', 'show'], 
	]

	# ------------------------------------------------- SHOW
	SHOW_FIELDS = [
		['email',   'normal'],
		['sha1',    'normal']
	]

	S_E = [:detalle]
	F_TABLA = 'administrador'

 	FORM_FIELDS = [
		['equipo',             'entry'],
		['perfil_id',         'hidden'],
	]
	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	belongs_to :administrador, class_name: 'Perfil'

	has_many :integrantes
	has_many :perfiles, through: :integrantes

	has_many :herencias
	has_many :carpetas, through: :herencias
end
