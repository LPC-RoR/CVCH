class Instancia < ApplicationRecord

	SHOW_FIELDS = [
		['instancia', 'show'], 
	]

	TABLA_FIELDS = [
		['instancia', 'show']
	]


	belongs_to :concepto, optional: true

	has_many :rutas
	has_many :publicaciones, through: :rutas
end
