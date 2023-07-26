class FiloCategoriaConservacion < ApplicationRecord

	TABLA_FIELDS = [
		'codigo',
		'filo_categoria_conservacion'
	]

	has_many :filo_especies

	scope :ordered, -> { order(:filo_categoria_conservacion) }

end
