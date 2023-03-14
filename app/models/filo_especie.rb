class FiloEspecie < ApplicationRecord
	belongs_to :filo_elemento, optional: true

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEspEsp"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEspEsp"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	has_many :especies

	def n_especies
		self.children.count
	end

	def n_hijos
		self.children.count
	end

	def padre
		self.filo_elemento.blank? ? self.parent : self.filo_elemento
	end

	def publicaciones_ids
		pub_ids = []
		self.especies.each do |esp|
			pub_ids = pub_ids.union(esp.publicaciones_ids)
		end
	end
end
