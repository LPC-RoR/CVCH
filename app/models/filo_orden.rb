class FiloOrden < ApplicationRecord

	TABLA_FIELDS = [
		['orden',  'normal'],
		['filo_orden', 'normal']
	]

	has_many :filo_elementos

end
