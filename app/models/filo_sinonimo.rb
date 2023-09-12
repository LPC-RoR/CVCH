class FiloSinonimo < ApplicationRecord

	has_one :especie

	has_many :filo_esp_sinos
	has_many :filo_especies, through: :filo_esp_sinos

	def conflicto?
		( self.filo_especies.count > 1 ) or ( self.especie.blank? ? false : self.especie.filo_especie.present? )
	end

end
