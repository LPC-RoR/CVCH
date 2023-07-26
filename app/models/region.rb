class Region < ApplicationRecord
  	TABLA_FIELDS = [
		's#region'
	]

	has_many :filo_f_esp_regs
	has_many :filo_especies, through: :filo_f_esp_regs

	scope :ordered, -> { order(:orden) }

 	# ------------------------------------ ORDER LIST

	def owner
		nil
	end

	def list
		Region.all.order(:orden)
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
		"/app_recursos/administracion?id=#{get_elemento_id(self.class.name.tableize, 'Regiones')}" 
	end

	# -----------------------------------------------

	def get_elemento_id(controlador, nombre_elemento)
		SbElemento.where(despliegue: 'list').where(controlador: controlador).find_by(elemento: nombre_elemento).id
	end

end
