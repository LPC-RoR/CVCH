class Investigador < ApplicationRecord
	# --------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['investigador',         'show']
	]

	# ---------------------------------------------------- SHOW

	# ----------------------------------------------------- DESPLIEGUE
	HIDDEN_CHILDS = ['autores', 'carpetas']

	belongs_to :departamento, optional: true

	has_one :perfil

	has_many :carpetas

	has_many :autores
	has_many :publicaciones, through: :autores

end
