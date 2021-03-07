class Revista < ApplicationRecord
	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['revista', 'show'], 
	]

 	FORM_FIELDS = [
		['revista',           'entry']
	]

	belongs_to :idioma, optional: true

	has_many :publicaciones
end
