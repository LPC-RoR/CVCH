class TemaAyuda < ApplicationRecord

	require 'carrierwave/orm/activerecord'

	TIPO = ['portada', 'inicio', 'tema', 'admin', 'mensaje', 'foot']

	TABLA_FIELDS = [
		['orden',    'normal'],
		['tema_ayuda', 'show'],
		['tipo',     'normal']
#		['archivo', 'link_file']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['orden',       'entry'],
		['tipo',        'entry'],
		['tema_ayuda',  'entry'],
		['detalle', 'text_area']
	]

	has_many :tutoriales

	validates :tipo, :orden, :tema_ayuda, :detalle, presence: true
	validates :orden, numericality: { only_integer: true }

	mount_uploader :ilustracion, IlustracionUploader

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
