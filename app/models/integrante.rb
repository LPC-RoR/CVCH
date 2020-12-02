class Integrante < ApplicationRecord
	belongs_to :investigador
	belongs_to :equipo
end
