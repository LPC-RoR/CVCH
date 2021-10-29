class ApplicationController < ActionController::Base

	include IniciaAplicacion

	def inicia_sesion
		if usuario_signed_in? and session[:perfil_base].blank?
			# Perro furioso

			set_tablas_base
			
			if ActiveRecord::Base.connection.table_exists? 'app_administradores'
				@dog = AppAdministrador.find_by(email: 'hugo.chinga.g@gmail.com')
				@dog = AppAdministrador.create(administrador: 'Hugo Chinga G.', email: 'hugo.chinga.g@gmail.com') if @dog.blank?
			else
				@dog = Administrador.find_by(email: 'hugo.chinga.g@gmail.com')
				@dog = Administrador.create(administrador: 'Hugo Chinga G.', email: 'hugo.chinga.g@gmail.com') if @dog.blank?
			end

			# En este minuto SIMULA que viene de la autenticacion con un usuario.email == 'hugo.chinga.g@gmail.com'
			# 1.- Verifica si Hay Perfil para ese correo
			if ActiveRecord::Base.connection.table_exists? 'app_administradores'
				@perfil = AppPerfil.find_by(email: current_usuario.email)
			else
				@perfil = Perfil.find_by(email: current_usuario.email)
			end

			if @perfil.blank?
				# TODAS las aplicaciones en Capitan tienen una tabla 'administradores'
				if ActiveRecord::Base.connection.table_exists? 'app_administradores'
					administrador = AppAdministrador.find_by(email: current_usuario.email)
				else
					administrador = Administrador.find_by(email: current_usuario.email)
				end

				if administrador.present?
					if ActiveRecord::Base.connection.table_exists? 'app_perfiles'
						@perfil = AppPerfil.create(email: current_usuario.email)
					else 
						@perfil = Perfil.create(email: current_usuario.email)
					end
					@perfil.save
				end

				# Las aplicaciones con Capitan que NO tienen tabla 'nominas' se asume que tienen LIBRE REGISTRO
				if ActiveRecord::Base.connection.table_exists? 'nominas'
					nomina = Nomina.find_by(email: current_usuario.email)
					if nomina.present?
						@perfil = (ActiveRecord::Base.connection.table_exists? 'app_perfiles' ? AppPerfil.create(email: current_usuario.email) : Perfil.create(email: current_usuario.email))
					end
				else
					# LIBRE REGISTRO
					@perfil = @perfil = (ActiveRecord::Base.connection.table_exists? 'app_perfiles' ? AppPerfil.create(email: current_usuario.email) : Perfil.create(email: current_usuario.email))
				end

				session[:hay_perfil]       = (@perfil.present? ? true : false)
			else
				session[:hay_perfil]       = true

				session[:perfil_base]      = @perfil
				session[:perfil_activo]    = @perfil
				if ActiveRecord::Base.connection.table_exists? 'app_administradores'
					session[:administrador]    = @perfil.app_administrador
					session[:es_administrador] = @perfil.app_administrador.present?
				else
					session[:administrador]    = @perfil.administrador
					session[:es_administrador] = @perfil.administrador.present?
				end

				inicia_app
			end
		end
	end

	# Este método se usa para construir un nombre de directorio a partir de un correo electrónico.
	def archivo_usuario(email, params)
		email.split('@').join('-').split('.').join('_')
	end

	def init_tab(tabs, tab_id)
		@tabs = tabs[0].class.name == 'String' ? tabs : tabs.map {|item| item[0] if item[1] }.compact
		if params[:html_options].blank?
		  @tab = @tabs[0]
		else
		  @tab = params[:html_options][:tab].blank? ? @tabs[0] : params[:html_options][:tab]
		end
	end

end
