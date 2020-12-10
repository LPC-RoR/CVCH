class Integrante < ApplicationRecord
	belongs_to :equipo
	belongs_to :perfil
end
