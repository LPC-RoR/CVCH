class EcoSet < ApplicationRecord

	belongs_to :eco_lugar
	belongs_to :publicacion

	has_many :filo_interacciones
	
end
