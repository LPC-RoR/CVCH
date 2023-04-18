class FiloOrden < ApplicationRecord

	TABLA_FIELDS = [
		'orden',
		'filo_orden'
	]

	has_many :filo_elementos

end
