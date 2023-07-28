class FiloEspEsp < ApplicationRecord
  belongs_to :parent, :class_name => "FiloEspecie", :inverse_of => :parent_relation
  belongs_to :child, :class_name => "FiloEspecie", :inverse_of => :child_relations
end
