class IndDireccion < ApplicationRecord
  belongs_to :origen, :class_name => "IndPalabra", :inverse_of => :origen_relations
  belongs_to :destino, :class_name => "IndPalabra", :inverse_of => :destino_relations
end
