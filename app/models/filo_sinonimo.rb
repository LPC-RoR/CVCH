class FiloSinonimo < ApplicationRecord

	has_one :especie

	has_many :filo_esp_sinos
	has_many :filo_especies, through: :filo_esp_sinos

	def conflicto?
		self.multiple? or self.sinonimo_especie?
	end

	def multiple?
		self.filo_especies.count > 1
	end

	def sinonimo_especie?
		self.especie.blank? ? false : ( self.especie.filo_especie.present? and (not self.especie.filo_especie.huerfana?) )
	end

	def nombre
		self.correccion.blank? ? self.filo_sinonimo : self.correccion
	end

	def n_pubs_propias
		self.especie.blank? ? 0 : self.especie.publicaciones.count
	end

end
