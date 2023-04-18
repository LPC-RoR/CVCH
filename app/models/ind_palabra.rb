class IndPalabra < ApplicationRecord

#	E_ESPANOL = ['a', 'al', 'así', 'alla', 'con', 'de', 'del', 'don', 'doña', 'el', 'en', 'la', 'las', 'le', 'les', 'los', 'más', 'no', 'o', 'para', 'que', 'qué', 'se', 'sic', 'su', 'sus', 'un', 'una', 'vs', 'y', '&']
#	E_INGLES = ['an', 'at', 'as', 'are', 'and', 'any', 'be', 'but', 'by', 'in', 'et', 'for', 'from', 'in', 'into', 'is', 'it', 'its', 'not', 'of', 'on', 'or', 'that', 'the', 'these', 'there', 'their', 'they', 'this', 'to', 'very', 'we', 'where', 'when', 'with']
#	NUMBERS = ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix', 'x', 'xi', 'x', 'xi', 'xii', 'xiii', 'xiv', 'xv', 'xvi', 'xvii', 'xviii', 'xix', 'xx']
	EXCEPTIONS = ['abstract', 'pp']

	TABLA_FIELDS = [
		's#ind_palabra',
		'd_indices'
	]

	belongs_to :ind_lenguaje, optional: true
	belongs_to :ind_clave, optional: true
	belongs_to :ind_estructura

	belongs_to :ind_sinonimo, optional: true

	has_many :ind_exp_pales
	has_many :ind_expresiones, through: :ind_exp_pales

	has_many :ind_indices

#	DEPRECATED
#	has_many :ind_redacciones
#	has_many :ind_expresiones, through: :ind_redacciones

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

	def d_indices
		self.ind_clave.present? ? "#{self.ind_clave.ind_indices.count}:#{self.ind_indices.count}" : "0:#{self.ind_indices.count}"
	end

end
