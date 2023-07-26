class FiloCategoriaConservacion < ApplicationRecord

	TABLA_FIELDS = [
		'codigo',
		'filo_categoria_conservacion'
	]

	scope :ordered, -> { order(:filo_categoria_conservacion) }

end
