class FiloEspEspSinonimo < ApplicationRecord
  belongs_to :especie, :class_name => "FiloEspecie", :inverse_of => :parent_relation
  belongs_to :sinonimo, :class_name => "FiloEspecie", :inverse_of => :child_relations
end
