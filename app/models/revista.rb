class Revista < ApplicationRecord
	belongs_to :idioma, optional: true

	has_many :publicaciones
end
