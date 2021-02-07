class Propuesta < ApplicationRecord

	TABLA_FIELDS = [
		['instancia', 'show']
	]

	belongs_to :instancia
	belongs_to :publicacion
	belongs_to :perfil, optional: true
end
