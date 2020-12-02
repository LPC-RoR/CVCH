class Autor < ApplicationRecord
	belongs_to :investigador
	belongs_to :publicacion
end
