class FiloTipoEspecie < ApplicationRecord

	TABLA_FIELDS = [
		'filo_tipo_especie'
	]

	has_many :filo_especies

	# *****************      CAMBIO RELACIONES

	has_many :filo_esp_tipos
	has_many :filo__especies, through: :filo_esp_tipos

	# ******************************************

	scope :ordered, -> { order(:filo_tipo_especie) }

end
