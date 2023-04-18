class FiloElemento < ApplicationRecord

	TABLA_FIELDS = [
		'filo_elemento',
		'nombre_padre'
	]

	belongs_to :filo_orden, optional: true
	belongs_to :area, optional: true

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
		subespecies = self.filo_especies.map {|fe| fe.children.count }.sum
		especies_hijos = self.children.map {|child| child.n_especies}.sum
		especies + subespecies + especies_hijos
	end

	def nombre_padre
		self.parent.blank? ? '-' : self.parent.filo_elemento
	end
end
