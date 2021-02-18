class Paso < ApplicationRecord
	belongs_to :tutorial

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
