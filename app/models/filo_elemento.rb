class FiloElemento < ApplicationRecord
	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEleEle"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEleEle"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child
end
