class Carga < ApplicationRecord
	# ----------------------------------------- CARGA
	# CARGA HACIA CARPETA
	# Carpeta destino
	CARPETA_CARGA = 'Revisar'

	# ----------------------------------------- HIDDEN CHILDS
	HIDDEN_CHILDS = ['procesos']

	# SE define pero no se usa, el cambio se hace en código al procesar carga.
	ESTADOS = ['ingreso', 'procesada']

	# ------------------------------------- TABLA ------------------------------------------
	TABLA_FIELDS = [
		['archivo_carga', 'url'], 
		['status',     'normal'],
		['nota',       'normal'],
		['estado',     'normal']
	]

 	FORM_FIELDS = [
		['area_id',           'select'],
		['nota',               'entry'],
		['archivo_carga', 'file_field'],
		['estado',            'hidden'],
		['perfil_id',         'hidden'],
		['archivo',           'hidden']
	]

	belongs_to :perfil
	belongs_to :area

	has_many :procesos
	has_many :publicaciones, through: :procesos

	mount_uploader :archivo_carga, ArchivoCargaUploader

	def show_title
		self.archivo.split('/').last
	end

	def status
		self.n_procesados.blank? ? '[ sin procesar ]' : "[ #{self.n_procesados} : (P) #{self.n_publicadas} + (C) #{self.n_carga} + (F) #{self.n_formatos} + (D) #{self.n_duplicados} + (A) #{self.n_areas} ]"
	end


	def show_links
		[
			['Proceso', "/cargas/procesa_carga?carga_id=#{self.id}", self.estado == 'ingreso']
		]
		
	end

	def d_archivo
		self.archivo.split('/').last
	end
end
