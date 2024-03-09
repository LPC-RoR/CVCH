class FiloDefRolInteraccion < ApplicationRecord

	belongs_to :filo_def_rol
	belongs_to :filo_def_interaccion
	
 	# ------------------------------------ ORDER LIST

	def owner
		self.filo_def_interaccion
	end

	def list
		owner.filo_def_rol_interacciones
	end

	def n_list
		self.list.count
	end

	def siguiente
		self.list.find_by(orden: self.orden + 1)
	end

	def anterior
		self.list.find_by(orden: self.orden - 1)
	end

	def redireccion
		"/tablas?tb=8"
	end

	# -----------------------------------------------

end
