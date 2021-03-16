class Especie < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['especie',  'show'], 
		['d_pubs', 'normal']
	]

 	FORM_FIELDS = [
		['especie',           'entry']
	]

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	def d_pubs
		self.publicaciones.count
	end
end
