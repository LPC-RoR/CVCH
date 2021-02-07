class Instancia < ApplicationRecord

	SHOW_FIELDS = [
		['instancia', 'show'], 
	]

	TABLA_FIELDS = [
		['instancia', 'show']
	]


	has_many :diccionarios
	has_many :conceptos, through: :diccionarios

	has_many :rutas
	has_many :publicaciones, through: :rutas

	has_many :propuestas
	has_many :aprobaciones, through: :propuestas, source: 'publicacion'
end
