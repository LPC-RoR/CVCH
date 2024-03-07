class FiloRol < ApplicationRecord
	belongs_to :filo_especie
	belongs_to :filo_interaccion

	def primer_rol?
		self.filo_rol == self.filo_interaccion.primer_rol.filo_rol
	end

	def otro_rol
		self.filo_interaccion.filo_roles.where.not(filo_rol: self.filo_rol).first
	end
end
