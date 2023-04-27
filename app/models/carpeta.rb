class Carpeta < ApplicationRecord

	NOT_MODIFY = ['Excluidas', 'Pstergadas', 'Revisadas', 'Revisar']

	TABLA_FIELDS = [
		's#carpeta',
		'sha1'
	]

 	FORM_FIELDS = [
		['carpeta',        'entry'],
		['app_perfil_id',     'hidden']
	]

#	belongs_to :perfil, optional: true
	belongs_to :app_perfil, optional: true

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	has_many :herencias
	has_many :equipos, through: :herencias

	has_many :per_cares
	has_many :app_perfiles, through: :per_cares

	has_many :car_filo_esps
	has_many :filo_especies, through: :car_filo_esps

	validates :carpeta, presence: true

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end

	def sel_table		
		self.publicaciones
	end

end