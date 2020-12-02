class Area < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = [
		'Aves',
		'Micromamíferos',
		'Mamíferos marinos',
		'Carnívoros', 
		'Ungulados',
		'Murciélagos y edentados',
		'Reptiles',
		'Invasores',
		'Conejos'
	]

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['area', 'show'], 
	]

 	FORM_FIELDS = [
		['area',           'entry']
	]

	# ------------------------------------------------------------- DESPLIEGUE
	HIDDEN_CHILDS = ['clasificaciones', 'cargas']
	SHOW_HMT_COLLECTIONS = ['papers']

	has_many :cargas

	has_many :clasificaciones
	has_many :papers, through: :clasificaciones, foreign_key: 'paper_id', class_name: 'Publicacion'

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end
end
