class Clasificacion < ApplicationRecord
	belongs_to :carpeta, optional: true
	belongs_to :publicacion, optional: true
	belongs_to :area, optional: true
	belongs_to :paper, optional:true, class_name: 'Publicacion'
end
