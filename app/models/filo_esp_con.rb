class FiloEspCon < ApplicationRecord
	belongs_to :filo_especie
	belongs_to :filo_categoria_conservacion
end
