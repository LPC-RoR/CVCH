class Instancia < ApplicationRecord

	TABLA_FIELDS = [
		['instancia', 'show'], 
	]

	HIDDEN_CHILDS = ['rutas']

	belongs_to :concepto, optional: true

	has_many :rutas
	has_many :publicaciones, through: :rutas
end
