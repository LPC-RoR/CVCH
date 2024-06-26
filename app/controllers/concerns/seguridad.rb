module Seguridad
	extend ActiveSupport::Concern

	# CONFIG

	def public_controllers
		# No incluimos 'publicaciones por seguridad', para no permitir modificar.
		['publicos', 'vistas', 'contribuciones']
	end

	# METHODS

	def version_activa
		AppVersion.last
	end

	def dog_name
		AppVersion::DOG_NAME
	end

	def dog_email
		AppVersion::DOG_EMAIL
	end

	def nomina_activa
		usuario_signed_in? ? AppNomina.find_by(email: current_usuario.email) : nil
	end

	def perfil_activo?
		usuario_signed_in? ? AppPerfil.find_by(email: current_usuario.email).present? : false
	end

	def perfil_activo
		usuario_signed_in? ? AppPerfil.find_by(email: current_usuario.email) : nil
	end

	def dog?
		usuario_signed_in? ? (current_usuario.email == dog_email) : false
	end

	def admin?
		es_admin = usuario_signed_in? ? ( nomina_activa.blank? ? false : ( nomina_activa.tipo == 'Admin' ) ) : false
		es_admin or dog?
	end

	def usuario?
		es_usuario = usuario_signed_in? ? ( nomina_activa.blank? ? false : ( nomina_activa.tipo == 'Usuario' ) ) : false
		es_usuario or dog?
	end

	# DEPRECATED : A futuro se introduce la categoría 'servicio para regular el acceso a los controladores de servicios.'
	def nomina?
		usuario_signed_in? ? AppNomina.find_by(email: current_usuario.email).present? : false
	end

	def publico?
		action_name == 'home' ? ( not usuario_signed_in?) : (public_controllers.include?(controller_name) or controller_name.match(/^blg_*/))
	end

	def seguridad(nivel)
		if nivel.blank?
			admin?
		else
			case nivel
			when 'dog'
				dog?
			when 'admin'
				admin?
			when 'usuario'
				usuario?
			when 'nomina'
				admin? or nomina?
			when 'excluir'
				false
			else
				true
			end
		end
	end

end