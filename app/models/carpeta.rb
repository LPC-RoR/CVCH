class Carpeta < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	#-------------------------------------------------------------  TABLA
	T_EXCEPTIONS = {
		nuevo:   ['equipos']
	}

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'equipos' => 'inline',
	}

 	FORM_FIELDS = [
		['carpeta',        'entry'],
		['perfil_id',     'hidden']
	]

	# ------------------------------------------------------------- DESPLIEGUE
	HIDDEN_CHILDS = ['clasificaciones']

	belongs_to :perfil, optional: true
	belongs_to :equipo, optional: true

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end
end
