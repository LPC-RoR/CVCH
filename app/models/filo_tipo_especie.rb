class FiloTipoEspecie < ApplicationRecord

	TABLA_FIELDS = [
		'filo_tipo_especie'
	]

	has_many :filo_especies

	scope :ordered, -> { order(:filo_tipo_especie) }

end
