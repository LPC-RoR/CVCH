class AppPerfil < ApplicationRecord

	has_many :app_observaciones
	has_many :app_mejoras
	has_many :app_mensajes

	has_many :blg_articulos

	# Aplicacion
	# Si cfg_defaults[:activa_tipos_usuario] = true
	# has_many :age_usuarios

	has_many :contacto_personas
	has_many :contacto_empresas

	has_many :carpetas
	has_many :cargas
	has_many :contribuciones, class_name: 'Publicacion'
	has_many :aportes, foreign_key: 'perfil_id', class_name: 'Categoria'

	has_many :equipos, foreign_key: 'app_administrador_id'

	has_many :per_equipos
	has_many :participaciones, through: :per_equipos, source: :equipo

	has_many :per_cares
	has_many :compartidas, through: :per_cares, source: :carpeta

	has_many :filo_conflictos

	def nombre_perfil
		self.email == AppVersion::DOG_EMAIL ? AppVersion::DOG_NAME : AppNomina.find_by(email: self.email).nombre
	end

	def tipo_usuario
		( self.email == AppVersion::DOG_EMAIL or cfg_defaults[:activa_tipos_usuario] == false ) ? 'general' : AppNomina.find_by(email: self.email).tipo
	end

	def app_enlaces
		AppEnlace.where(owner_class: 'AppPerfil', owner_id: self.id)
	end

end
