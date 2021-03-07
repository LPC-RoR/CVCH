class Suscripcion < ApplicationRecord
	belongs_to :perfil
	belongs_to :categoria
end
