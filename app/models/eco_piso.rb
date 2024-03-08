class EcoPiso < ApplicationRecord

	belongs_to :eco_formacion

	has_many :eco_lugares

 	# ------------------------------------ ORDER LIST

	def owner
		self.eco_formacion
	end

	def list
		owner.eco_pisos.all.order(:orden)
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