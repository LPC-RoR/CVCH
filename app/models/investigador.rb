class Investigador < ApplicationRecord
	# --------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['investigador',         'show']
	]

	# ---------------------------------------------------- SHOW

	belongs_to :departamento, optional: true

	has_many :autores
	has_many :publicaciones, through: :autores

end
