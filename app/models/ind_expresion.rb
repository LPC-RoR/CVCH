class IndExpresion < ApplicationRecord
	TABLA_FIELDS = [
		['ind_expresion', 'show']
	]

	belongs_to :ind_estructura

	has_many :ind_redacciones
	has_many :ind_palabras, through: :ind_redacciones
end
