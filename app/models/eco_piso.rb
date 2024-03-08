class EcoPiso < ApplicationRecord

	belongs_to :eco_formacion

	has_many :eco_lugares
end
