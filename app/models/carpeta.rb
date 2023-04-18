class Carpeta < ApplicationRecord

	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Revisar', 'Excluidas', 'Postergadas', 'Revisadas']

	TABLA_FIELDS = [
		['carpeta', 'show'], 
	]

 	FORM_FIELDS = [
		['carpeta',        'entry'],
		['perfil_id',     'hidden']
	]

#	belongs_to :perfil, optional: true
	belongs_to :app_perfil, optional: true

	has_many :clasificaciones
	has_many :publicaciones, through: :clasificaciones

	has_many :herencias
	has_many :equipos, through: :herencias

	validates :carpeta, presence: true

	def btns_control
		not NOT_MODIFY.include?(self.carpeta)
	end

	def sel_table		
		self.publicaciones
	end
end

