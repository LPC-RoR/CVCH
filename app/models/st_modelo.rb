class StModelo < ApplicationRecord
	has_many :st_estados

    validates_presence_of :st_modelo

	def primer_estado
		self.st_estados.empty? ? nil : self.st_estados.order(:orden).first
	end

	def control_documentos
		ControlDocumento.where(o_clss: self.class.name, o_id: self.id).order(:orden)
	end

end
