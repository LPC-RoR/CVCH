class FiloActualizacion < ApplicationRecord

	belongs_to :filo_fuente
	belongs_to :filo_especie

	scope :ordered, -> { order(updated_at: :desc) }
end
