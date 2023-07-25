class FiloOrden < ApplicationRecord

	TABLA_FIELDS = [
		'filo_orden'
	]

	has_many :filo_elementos

	# ------------------------------------ ORDER LIST

	def owner
		nil
	end

	def list
		FiloOrden.all.order(:orden)
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
		"/especies?html_options[menu]=Estructura"
	end

	# -----------------------------------------------

end
