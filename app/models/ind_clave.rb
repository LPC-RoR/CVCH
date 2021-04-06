class IndClave < ApplicationRecord
	belongs_to :ind_estructura

	has_many :ind_palabras
	has_many :ind_indices
end
