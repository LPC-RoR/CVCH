class TemaAyuda < ApplicationRecord
	TIPO = ['inicio', 'tema']

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

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
