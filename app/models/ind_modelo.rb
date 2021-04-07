class IndModelo < ApplicationRecord
	TABLA_FIELDS = [
		['ind_modelo', 'normal']
	]

	FORM_FIELDS = [
		['ind_modelo',         'entry'],
		['campos',             'entry'],
		['ind_estructura_id', 'hidden']
	]

	belongs_to :ind_estructura

end
