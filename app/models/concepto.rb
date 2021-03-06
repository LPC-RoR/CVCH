class Concepto < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	TABS = ['instancias', 'hijos']

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['concepto',            'show'] 
	]

 	FORM_FIELDS = [
		['concepto',           'entry'],
		['administracion', 'check_box'],
		['perfil_id',         'hidden']
	]

	belongs_to :perfil

	has_many :diccionarios
	has_many :instancias, through: :diccionarios

	has_one :rel_padre, foreign_key: 'hijo_id', class_name: 'Ascendencia'
	has_many :rel_hijos, foreign_key: 'padre_id', class_name: 'Ascendencia'

	has_one :padre, through: :rel_padre
	has_many :hijos, through: :rel_hijos

	validates :concepto, presence: true
	validates :concepto, uniqueness: true

end
