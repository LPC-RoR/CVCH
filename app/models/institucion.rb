class Institucion < ApplicationRecord
	has_many :departamentos
	has_many :registros
end
