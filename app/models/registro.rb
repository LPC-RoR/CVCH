class Registro < ApplicationRecord
	belongs_to :institucion

	has_one :publicacion
end
