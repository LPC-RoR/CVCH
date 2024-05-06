class FiloInteraccion < ApplicationRecord

	belongs_to :publicacion
	belongs_to :filo_def_interaccion
	belongs_to :eco_set, optional: true

	has_many :filo_roles

	def def_rol(orden)
		self.filo_def_interaccion.filo_def_rol_inetreacciones.find_by(orden: orden).filo_def_rol
	end

	def nombre_def_rol(orden)
		self.def_rol(orden).blank? ? '-' : self.def_rol(orden).filo_def_rol
	end

	def rol(orden)
		self.filo_roles.find_by(filo_rol: self.nombre_def_rol(orden))
	end

	def nombre_especie(orden)
		self.rol(orden).blank? ? '-' : self.rol(orden).filo_especie.filo_especie
	end

	# Revisar uso de los siguientes métodos para llevarlos al uso de los anteriores

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
