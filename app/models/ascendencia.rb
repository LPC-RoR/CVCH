class Ascendencia < ApplicationRecord
  belongs_to :padre, class_name: "Concepto", inverse_of: :rel_padre
  belongs_to :hijo, class_name: "Concepto", inverse_of: :rel_hijos
end
