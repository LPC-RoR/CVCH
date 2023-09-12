class FiloSinonimo < ApplicationRecord

	has_one :especie

	has_many :filo_esp_sinos
	has_many :filo_especies, through: :filo_esp_sinos

end
