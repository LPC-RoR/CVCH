class Area < ApplicationRecord
	# MARCA CARPETAS QUE NO SE MODIFICAN NI ELIMINAN
	NOT_MODIFY = ['Aves','Micromamíferos','Mamíferos marinos','Carnívoros', 'Ungulados','Murciélagos y edentados','Reptiles','Invasores','Conejos']

	#-------------------------------------------------------------  TABLA
	TABLA_FIELDS = [
		['area', 'show'], 
	]

 	FORM_FIELDS = [
		['area',           'entry']
	]

	
	has_many :cargas

	has_many :clasificaciones
	has_many :papers, through: :clasificaciones, foreign_key: 'paper_id', class_name: 'Publicacion'

	has_many :esp_areas
	has_many :especies, through: :esp_areas

	validates :area, presence: true
	validates :area, uniqueness: true

	def especies_ids
		bug_ids = []
		self.papers.each do |pub|
			bug_ids << pub.especies.ids
		end
		bug_ids.uniq
	end

end
