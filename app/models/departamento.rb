class Departamento < ApplicationRecord
	belongs_to :instituciones

	has_many :investigadores
end
