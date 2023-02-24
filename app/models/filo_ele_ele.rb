class FiloEleEle < ApplicationRecord
  belongs_to :parent, :class_name => "FiloElemento", :inverse_of => :parent_relation
  belongs_to :child, :class_name => "FiloElemento", :inverse_of => :child_relations
end
