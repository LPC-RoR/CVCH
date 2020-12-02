class Proceso < ApplicationRecord
	belongs_to :carga
	belongs_to :publicacion
end
