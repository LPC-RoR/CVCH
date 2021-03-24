class Observacion < ApplicationRecord

	TABLA_FIELDS = [
		['observacion', 'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['observacion',     'entry'],
		['publicacion_id', 'hidden']
	]

	belongs_to :publicacion, optional: true

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
