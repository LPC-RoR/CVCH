class Especie < ApplicationRecord

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		's#d_especie',
		'd_especie_ref',
		'd_pubs',
		'd_areas'
	]

 	FORM_FIELDS = [
		['especie',           'entry']
	]

	belongs_to :filo_especie, optional: true
	belongs_to :filo_sinonimo, optional: true

	has_many :etiquetas
	has_many :publicaciones, through: :etiquetas

	# ************************* Taxonomia
	def propia?
		self.filo_especie.blank? ? false : self.especie == self.filo_especie.filo_especie
	end

	def conflictos
		FiloConflicto.where(id: FiloConfElem.where(filo_elem_class: self.class.name, filo_elem_id: self.id).map {|fe| fe.filo_conflicto.id})
	end
	# ***********************************

	def d_pubs
		self.publicaciones.count
	end

	def d_areas
		self.areas.count
	end

	def d_especie
		self.especie.capitalize
	end

	def d_especie_ref
		self.filo_especie.blank? ? '-' : self.filo_especie.filo_especie
	end

end
