class FiloElemento < ApplicationRecord

	belongs_to :filo_orden
	belongs_to :area, optional: true

	# **************************************** PARENT - CHILDREN

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEleEle"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEleEle"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	# **************************************** 1 TO MANY

	has_many :filo_especies

	# **************************************** ACTIONS

	validates :filo_elemento, presence: true

	before_save { self.filo_elemento.downcase! }

	# **************************************** OWNER RELATIONS

	# Determina laa indentación de la especie en el árbol desplegado
	def n_indent
		self.filo_orden.blank? ? 0 : self.filo_orden.orden.to_i * 2
	end

	# Entrega una lista de padres
	def padres
 		padre = self.parent
		padre.present? ? [padre].union(padre.padres) : []
	end

	# TOTAL de publicacines Recursiva
	def n_pubs
		self.filo_especies.map {|esp| esp.n_pubs}.sum + self.children.map {|child| child.n_pubs}.sum
	end

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