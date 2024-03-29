class HImagen < ApplicationRecord

	TABLA_FIELDS = [
		's#nombre'
	]

	scope :ordered, -> { order(:h_imagen) }

 	def imagenes
		img_class = AppImagen.where(owner_class: 'HImagen')
		img_class.blank? ? img_class : img_class.where(owner_id: self.id).order(created_at: :desc)
	end

	def imagen(nombre)
		nombre.blank? ? self.imagenes.order(created_at: :desc).first : self.imagenes.find_by(nombre: nombre)
	end

end
