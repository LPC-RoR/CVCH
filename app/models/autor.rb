class Autor < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['autor', 'show'], 
	]

 	FORM_FIELDS = [
		['autor',           'entry']
	]

	belongs_to :investigador
	belongs_to :publicacion
end
