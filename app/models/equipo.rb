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

 	FORM_FIELDS = [
		['equipo',             'entry'],
		['perfil_id',         'hidden'],
	]
	# -------------------------------------------------- DESPLIEGUE
	MY_FIELDS = ['sha1']

	belongs_to :administrador, class_name: 'Perfil', optional: true
	belongs_to :app_administrador, class_name: 'AppPerfil', optional: true

	has_many :integrantes
	has_many :perfiles, through: :integrantes

	has_many :per_equipos
	has_many :app_perfiles, through: :per_equipos

	has_many :herencias
	has_many :carpetas, through: :herencias

	validates :sha1, uniqueness: true

	def status
		"| #{self.administrador.email} | #{self.sha1} |"
	end

end
