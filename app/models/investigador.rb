class Investigador < ApplicationRecord
	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['autores', 'carpetas']

	# --------------------------------------------------- TABLA
	TABLA_FIELDS = [
		['investigador',         'show']
	]

	# ---------------------------------------------------- SHOW

	belongs_to :departamento, optional: true

	has_one :perfil

	has_many :carpetas

	has_many :autores
	has_many :publicaciones, through: :autores

end
