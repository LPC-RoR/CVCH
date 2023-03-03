class IndIdea < ApplicationRecord
	belongs_to :ind_estructura

	has_many :ind_ide_exps
	has_many :ind_expresiones, through: :ind_ide_exps
end
