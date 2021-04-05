class IndPalabra < ApplicationRecord
	belongs_to :ind_lenguaje, optional: true
	belongs_to :ind_clave

	has_many :origen_relations, :foreign_key => "destino_id", :class_name => "IndDireccion"
	has_many :destino_relations, :foreign_key => "origen_id", :class_name => "IndDireccion"

	has_many :origenes, :through => :origen_relations, :source => :origen
	has_many :destinos, :through => :destino_relations, :source => :destino


	has_one  :clave_relation, :foreign_key => "ind_palabra_id", :class_name => "IndBase"
	has_many :ind_palabras_relations, :foreign_key => "clave_id", :class_name => "IndBase"

	has_one  :clave, :through => :clave_relation
	has_many :ind_palabras, :through => :ind_palabras_relations, :source => :ind_palabra

end
