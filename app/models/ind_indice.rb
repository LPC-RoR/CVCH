class IndIndice < ApplicationRecord

	TABLA_FIELDS = [
		['class_name', 'normal'],
		['objeto_id', 'normal']
	]

	belongs_to :ind_estructura, optional: true
	belongs_to :ind_clave, optional: true
	belongs_to :ind_palabra
end
