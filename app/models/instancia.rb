class Instancia < ApplicationRecord

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['rutas']

	SHOW_FIELDS = [
		['instancia', 'show'], 
	]

	TABLA_FIELDS = [
		['instancia', 'show']
	]

	# [0] : Nombre del boton
	# [1] : link base, a esta base se le agrega el instancia_id
	# [2] : Si es true se agrega "objeto_id=#{@objeto.id}"
	X_BTNS = [
		['Eliminar', '/instancias/', '/elimina_instancia', true]
	]


	belongs_to :concepto, optional: true

	has_many :rutas
	has_many :publicaciones, through: :rutas
end
