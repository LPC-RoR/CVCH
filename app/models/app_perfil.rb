class AppPerfil < ApplicationRecord

	TABLA_FIELDS = [
		['email', 'normal'], 
	]


	belongs_to :app_administrador, optional: true

	has_many :app_observaciones
	has_many :app_mejoras

	has_many :carpetas
	has_many :cargas
	has_many :contribuciones, class_name: 'Publicacion'
	has_many :aportes, foreign_key: 'perfil_id', class_name: 'Categoria'

	has_many :equipos, foreign_key: 'app_administrador_id'

	has_many :per_equipos
	has_many :participaciones, through: :per_equipos, source: :equipo


end
