class Carga < ApplicationRecord
	# ----------------------------------------- CARGA
	# CARGA HACIA CARPETA
	# Carpeta destino
	CARPETA_CARGA = 'Revisar'

	# SE define pero no se usa, el cambio se hace en código al procesar carga.
	ESTADOS = ['ingreso', 'procesada']

	# ------------------------------------- TABLA ------------------------------------------
	TABLA_FIELDS = [
		['d_archivo',   'show'], 
		['nota',      'normal']
	]

 	FORM_FIELDS = [
		['area_id',         'select'],
		['nota',             'entry'],
		['estado',          'hidden'],
		['investigador_id', 'hidden'],
		['archivo',         'hidden']
	]

	# ----------------------------------------- DESPLIEGUE
	# CHILDS QUE NO SE DEBEN DESPLEGAR
	HIDDEN_CHILDS = ['procesos']

	belongs_to :investigador
	belongs_to :area

	has_many :procesos
	has_many :publicaciones, through: :procesos

	def show_title
		" Archivo Carga : #{self.archivo.split('/').last}"
	end


	def show_links
		[
			['Proceso', "/cargas/#{self.id}/procesa_carga", self.estado == 'ingreso']
		]
		
	end

	def d_archivo
		self.archivo.split('/').last
	end
end
