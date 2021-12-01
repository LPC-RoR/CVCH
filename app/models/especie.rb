class Especie < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['d_especie',  'show'], 
		['d_pubs', 'valor'],
		['d_areas', 'valor']
	]

 	FORM_FIELDS = [
		['especie',           'entry']
	]

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	has_many :esp_areas
	has_many :areas, through: :esp_areas

	def d_pubs
		self.publicaciones.count
	end

	def d_areas
		self.areas.count
	end

	def d_especie
		self.especie.capitalize
	end
end
