class Especie < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['especie', 'show'], 
	]

 	FORM_FIELDS = [
		['especie',           'entry']
	]

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas
end
