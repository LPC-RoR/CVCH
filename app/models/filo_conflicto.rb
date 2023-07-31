class FiloConflicto < ApplicationRecord
	belongs_to :app_perfil

	has_many :filo_conf_elems

	def especies
		FiloEspecie.where(id: self.filo_conf_elems.where(filo_elem_class: 'FiloElemento').map {|fee| fee.filo_elem_id})
	end

	def etiquetas
		FiloEspecie.where(id: self.filo_conf_elems.where(filo_elem_class: 'Especie').map {|fee| fee.filo_elem_id})
	end

end
