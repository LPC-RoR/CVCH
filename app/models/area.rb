class Area < ApplicationRecord
 
	has_many :filo_elementos
	
	has_many :cargas

	has_many :clasificaciones
	has_many :papers, through: :clasificaciones, foreign_key: 'paper_id', class_name: 'Publicacion'

	validates :area, presence: true
	validates :area, uniqueness: true

	scope :ordered, -> { order(:area) }

	def especies_ids
		bug_ids = []
		self.papers.each do |pub|
			bug_ids << pub.especies.ids
		end
		bug_ids.uniq
	end

	def sel_table
		self.papers.where(estado: 'publicada')
	end

end
