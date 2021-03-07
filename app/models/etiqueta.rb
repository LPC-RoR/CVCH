class Etiqueta < ApplicationRecord
	belongs_to :categoria, optional: true
	belongs_to :publicacion
	belongs_to :especie, optional: true
end
