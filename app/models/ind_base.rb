class IndBase < ApplicationRecord
  belongs_to :clave, :class_name => "IndPalabra", :inverse_of => :clave_relation
  belongs_to :ind_palabra, :class_name => "IndPalabra", :inverse_of => :ind_palabras_relations
end
