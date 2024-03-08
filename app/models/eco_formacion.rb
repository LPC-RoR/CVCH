class EcoFormacion < ApplicationRecord

	has_many :eco_pisos
	
 	# ------------------------------------ ORDER LIST

	def owner
		nil
	end

	def list
		EcoFormacion.all.order(:orden)
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
		"/tablas?tb=10" 
	end

	# -----------------------------------------------

end
