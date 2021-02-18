class Mejora < ApplicationRecord
	TABLA_FIELDS = [
		['mejora', 'show']
	]

	# -------------------- FORM  -----------------------
 	FORM_FIELDS = [
		['mejora',          'entry'],
		['publicacion_id', 'hidden']
	]

	belongs_to :publicacion, optional: true

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
