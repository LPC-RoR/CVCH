class Mensaje < ApplicationRecord
	TABLA_FIELDS = [
		['fecha_envio', 'diahora'], 
		['mensaje',        'show'],
		['email',        'normal']
	]


	belongs_to :perfil, optional: true

	has_one  :parent_relation, :foreign_key => "child_id",
                              :class_name => "Relacion"
	has_many :child_relations, :foreign_key => "parent_id", 
                              :class_name => "Relacion"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	def d_detalle
	  self.detalle.blank? ? '' : self.detalle.gsub(/\n/, '<br>')
	end
end
