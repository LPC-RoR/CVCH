class FiloCategoriaConservacion < ApplicationRecord

	TABLA_FIELDS = [
		'codigo',
		'filo_categoria_conservacion'
	]

#	has_many :filo_especies

	# *****************      CAMBIO RELACIONES

	has_many :filo_esp_cones
	has_many :filo_especies, through: :filo_esp_cones

	# ******************************************

	scope :ordered, -> { order(:filo_categoria_conservacion) }

end
