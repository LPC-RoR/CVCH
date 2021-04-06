class IndPalabra < ApplicationRecord

	TABLA_FIELDS = [
		['ind_palabra', 'show'],
		['d_ordering', 'normal']
	]

	belongs_to :ind_lenguaje, optional: true
	belongs_to :ind_clave
	belongs_to :ind_estructura

	has_many :ind_redacciones
	has_many :ind_expresiones, through: :ind_redacciones

	has_many :origen_relations, :foreign_key => "destino_id", :class_name => "IndDireccion"
	has_many :destino_relations, :foreign_key => "origen_id", :class_name => "IndDireccion"

	has_many :origenes, :through => :origen_relations, :source => :origen
	has_many :destinos, :through => :destino_relations, :source => :destino


	has_one  :clave_relation, :foreign_key => "ind_palabra_id", :class_name => "IndBase"
	has_many :ind_palabras_relations, :foreign_key => "clave_id", :class_name => "IndBase"

	has_one  :clave, :through => :clave_relation
	has_many :ind_palabras, :through => :ind_palabras_relations, :source => :ind_palabra

	def d_ordering
		self.ind_palabra.split('').map {|c| c.ord}.join(' ')
	end

end
