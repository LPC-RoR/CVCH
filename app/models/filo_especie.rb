class FiloEspecie < ApplicationRecord

	TABLA_FIELDS = [
		's#filo_especie'
	]

	belongs_to :filo_elemento, optional: true
	belongs_to :filo_categoria_conservacion
	belongs_to :filo_tipo_especie

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEspEsp"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEspEsp"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	has_one :especie_padre, foreign_key: 'sinonimo_id', class_name: 'FiloEspEspSinonimo'
	has_many :especies_sinonimos, foreign_key: 'especie_id', class_name: 'FiloEspEspSinonimo'

	has_one :especie_actual, through: :especie_padre, source: :especie
	has_many :sinonimos, through: :especies_sinonimos, source: :sinonimo

	has_many :car_filo_esps
	has_many :carpetas, through: :car_filo_esps

	has_many :filo_f_esp_regs
	has_many :regiones, through: :filo_f_esp_regs

	has_many :especies

	def n_especies
		self.children.count
	end

	def n_hijos
		self.children.count
	end

	def padre
		self.filo_elemento.blank? ? (self.especie_actual.blank? ? self.parent : self.especie_actual) : self.filo_elemento
	end

	def publicaciones_ids
		pub_ids = []
		self.especies.each do |esp|
			pub_ids = pub_ids.union(esp.publicaciones.ids)
		end
		pub_ids
	end
end
