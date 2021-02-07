class Diccionario < ApplicationRecord
	belongs_to :concepto
	belongs_to :instancia
end
