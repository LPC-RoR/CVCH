class Relacion < ApplicationRecord
  belongs_to :parent, :class_name => "Mensaje", :inverse_of => :parent_relation
  belongs_to :child, :class_name => "Mensaje", :inverse_of => :child_relations
end
