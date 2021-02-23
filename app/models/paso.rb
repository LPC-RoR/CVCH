class Paso < ApplicationRecord
	belongs_to :tutorial

	validates :orden, :paso, :detalle, presence: true
	validates :orden, numericality: { only_integer: true }

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
