class FiloEspEsp < ApplicationRecord
  belongs_to :parent, :class_name => "FiloEspecie", :inverse_of => :especie_padre
  belongs_to :child, :class_name => "FiloEspecie", :inverse_of => :especies_sinonimos
end
