class Categoria < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['categoria',         'show'], 
		['d_publicaciones', 'normal'] 
	]

 	FORM_FIELDS = [
		['categoria',  'entry'],
		['base',   'check_box'],
		['perfil_id', 'hidden']
	]

	belongs_to :perfil

	has_many :suscripciones
	has_many :perfiles, through: :suscripciones

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	def d_publicaciones
		self.publicaciones.count
	end
end
