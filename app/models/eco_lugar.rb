class EcoLugar < ApplicationRecord

	belongs_to :eco_piso
	belongs_to :region

	has_many :eco_sets
end
