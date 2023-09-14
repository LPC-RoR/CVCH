class FiloFuente < ApplicationRecord

	TABLA_FIELDS = [
		'filo_fuente'
	]

	has_many :filo_actualizaciones

	scope :ordered, -> { order(:filo_fuente) }

	validates :filo_fuente, presence: true

end
