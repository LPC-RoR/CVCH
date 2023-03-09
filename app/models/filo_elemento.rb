class FiloElemento < ApplicationRecord

	TABLA_FIELDS = [
		['filo_elemento',  'normal']
	]

	belongs_to :filo_orden, optional: true

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEleEle"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEleEle"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	has_many :filo_especies

	def n_hijos
		self.children.count + self.filo_especies.count
	end

	def n_especies
		especies = self.filo_especies.count
		especies_hijos = self.children.map {|child| child.n_especies}.sum
		especies + especies_hijos
	end
end
