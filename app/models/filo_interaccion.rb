class FiloInteraccion < ApplicationRecord

	belongs_to :publicacion
	belongs_to :filo_def_interaccion

	has_many :filo_roles

	def primer_def_rol
		self.filo_def_interaccion.filo_def_rol_interacciones.find_by(orden: 1).filo_def_rol
	end

	def segundo_def_rol
		self.filo_def_interaccion.filo_def_rol_interacciones.find_by(orden: 2).filo_def_rol
	end

	def primer_rol
		self.primer_def_rol.blank? ? nil : self.filo_roles.find_by(filo_rol: self.primer_def_rol.filo_def_rol)
	end

	def segundo_rol
		self.segundo_def_rol.blank? ? nil : self.filo_roles.find_by(filo_rol: self.segundo_def_rol.filo_def_rol)
	end
end
