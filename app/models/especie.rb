class Especie < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		's#d_especie',
		'd_especie_ref',
		'd_pubs',
		'd_areas'
	]

 	FORM_FIELDS = [
		['especie',           'entry']
	]

	belongs_to :filo_especie, optional: true

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	has_many :esp_areas
	has_many :areas, through: :esp_areas

	# ************************* Taxonomia
	def propia?
		self.filo_especie.blank? ? false : self.especie == self.filo_especie.filo_especie
	end
	# ***********************************

	def d_pubs
		self.publicaciones.count
	end

	def d_areas
		self.areas.count
	end

	def d_especie
		self.especie.capitalize
	end

	def d_especie_ref
		self.filo_especie.blank? ? '-' : self.filo_especie.filo_especie
	end

end
