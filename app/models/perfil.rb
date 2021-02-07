class Perfil < ApplicationRecord
	TABLA_FIELDS = [
		['m_padre', 'show'], 
	]


	belongs_to :administrador, optional: true

	has_many :equipos, foreign_key: 'administrador_id'
	
	has_many :carpetas
	has_many :cargas
	has_many :contribuciones, class_name: 'Publicacion'
	has_many :evaluaciones
	has_many :conceptos

	has_many :rutas
	has_many :propuestas

	has_many :integrantes
	has_many :participaciones, through: :integrantes, source: :equipo

	def m_padre
		if self.investigador.present?
			self.investigador.email
		elsif self.equipo.present?
			self.equipo.equipo
		end				
	end
end
