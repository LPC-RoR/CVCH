class Categoria < ApplicationRecord

	has_many :suscripciones
	has_many :perfiles, through: :suscripciones

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	scope :ordered, -> { order(:categoria) }

 	def d_publicaciones
		self.publicaciones.count
	end

	def sel_table
		self.publicaciones.where(estado: 'publicada')
	end

end
