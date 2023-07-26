class FiloTipoEspecie < ApplicationRecord

	TABLA_FIELDS = [
		'filo_tipo_especie'
	]

	scope :ordered, -> { order(:filo_tipo_especie) }

end
