class Instancia < ApplicationRecord

	TABLA_FIELDS = [
		['instancia', 'show'], 
	]

	belongs_to :concepto

	has_many :rutas
	has_many :publicaciones, through: :rutas
end
