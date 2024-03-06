module Inicia
	extend ActiveSupport::Concern

	def dog_wanted
		dog_forgoted = AppPerfil.find_by(email: dog_email)
		if dog_forgoted.blank?
			AppPerfil.create(o_clss: 'AppVersion', o_id: version_activa.id, email: dog_email)
		else
			dog_forgoted.o_clss = 'AppVersion'
			dog_forgoted.o_id = version_activa.id
			dog_forgoted.save
		end
	end

	def inicia_sesion

		# Verifica registros BASE
		AppVersion.create(dog_email: dog_email) if version_activa.blank?
		dog_wanted if version_activa.dog_perfil.blank?

		# MIGRACION -----------
		version = version_activa
		if version.app_nombre.blank? or version.app_sigla.blank?
			version.app_nombre = 'Repositorio de citas bibliográficas de vertebrados de Chile'
			version.app_sigla = 'cvch'
			version.save
		end

		# si hay USUARIO AUTENTICADO pero el usuario NO TIENE PERFIL}
		# ocurre si es el primer acceso a la aplicación o si el usuario recién se creo
		if usuario_signed_in? and perfil_activo.blank?

			# crea perfil si está en archivo de administradores o en nómina o aplicación es de libre registro
			administrador = AppAdministrador.find_by(email: current_usuario.email)
			nomina = AppNomina.find_by(email: current_usuario.email)

			if nomina.present? or administrador.present? or libre_registro?
				perfil = AppPerfil.create(email: current_usuario.email)
			end

		end

		# lo puse aqui porque dog ya estaba creado
		set_tablas_base if SbLista.all.empty?

		# si hay perfil_activo ? hay usuarios se inicia applicacion : se despliega home SIN perfil_activo
		inicia_app if perfil.present?

	end

end