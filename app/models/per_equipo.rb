class PerEquipo < ApplicationRecord
	belongs_to :app_perfil
	belongs_to :equipo
end
