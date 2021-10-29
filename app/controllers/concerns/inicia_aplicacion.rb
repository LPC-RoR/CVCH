module IniciaAplicacion
	extend ActiveSupport::Concern

	def set_tablas_base
		
		# VERIFICA QUE TABLAS Y REGISTROS MINIMOS ESTÉN PRESENTES Y MIGRADOS SI CORRESPONDE
		# SB_ADMINISTRACION

		# SB_LISTAS

		if ActiveRecord::Base.connection.table_exists? 'sb_listas'
			# LISTA ADMINISTRACION
			lista = SbLista.find_by(lista: 'Administración')
			if lista.blank?
				lista = SbLista.create(lista: 'Administración', acceso: 'admin', link: '/recursos/administracion')
			end

			if ActiveRecord::Base.connection.table_exists? 'sb_elementos'
				elementos = lista.sb_elementos

				e_1 = elementos.find_by(elemento: 'Administradores')
				if e_1.blank?
					lista.sb_elementos.create(orden: 1, nivel: 1, tipo: 'item', elemento: 'Administradores', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'app_administradores')
				end

				e_2 = elementos.find_by(elemento: 'Nómina')
				if e_2.blank?
					lista.sb_elementos.create(orden: 2, nivel: 1, tipo: 'item', elemento: 'Nómina', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'app_nominas')
				end

				e_3 = elementos.find_by(elemento: 'Perfiles')
				if e_3.blank?
					lista.sb_elementos.create(orden: 3, nivel: 1, tipo: 'item', elemento: 'Perfiles', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'app_perfiles')
				end

				e_4 = elementos.find_by(elemento: 'Menús Laterales')
				if e_4.blank?
					lista.sb_elementos.create(orden: 4, nivel: 1, tipo: 'item', elemento: 'Menús Laterales', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'sb_listas')
				end

				e_5 = elementos.find_by(elemento: 'Tutoriales')
				if e_5.blank?
					lista.sb_elementos.create(orden: 5, nivel: 1, tipo: 'item', elemento: 'Tutoriales', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'hlp_tutoriales')
				end
			end

			# LISTA AYUDA
			ayuda = SbLista.find_by(lista: 'Ayuda')
			if ayuda.blank?
				ayuda = SbLista.create(lista: 'Ayuda', acceso: 'admin', link: '/recursos/ayuda')
			end
		end		

		# APP_ADMINISTRADORES SIN _IDS QUE MIGRAR

		if ActiveRecord::Base.connection.table_exists? 'app_administradores'
			# DOG
			dog = AppAdministrador.find_by(email: 'hugo.chinga.g@gmail.com')
			if dog.blank?
				AppAdministrador.create(administrador: 'Hugo Chinga G.', email: 'hugo.chinga.g@gmail.com')
			end

			if AppAdministrador.all.empty?
				if ActiveRecord::Base.connection.table_exists? 'administradores'
					Administrador.all.each do |adm|
						app_adm = AppAdministrador.find_by(email: adm.email)
						if app_adm.blank?
							AppAdministrador.create(administrador: adm.administrador, email: adm.email)
						end
					end
				end
			end
		end
		
		# APP_NOMINAS SIN _IDS QUE MIGRAR

		if ActiveRecord::Base.connection.table_exists? 'app_nominas'
			if AppNomina.all.empty?
				if ActiveRecord::Base.connection.table_exists? 'nominas'
					Nomina.all.each do |nom|
						app_nom = AppNomina.find_by(email: nom.email)
						if app_nom.blank?
							AppNomina.create(nombre: nom.nombre, email: nom.email, tipo: nom.tipo)
						end
					end
				end
			end
		end

		# APP_PERFILES

		if ActiveRecord::Base.connection.table_exists? 'app_perfiles'
			if AppPerfil.all.empty?
				if ActiveRecord::Base.connection.table_exists? 'perfiles'
					Perfil.all.each do |per|
						app_perfil = AppPerfil.find_by(email: per.email)
						if app_perfil.blank?
							app_perfil = AppPerfil.create(usuario_id: current_usuario.id, email: per.email)
							administrador = AppAdministrador.find_by(email: per.email)
							if administrador.present?
								app_perfil.app_administrador = administrador
								app_perfil.save
							end
						end
						# se migran las CARPETAS
						per.carpetas.each do |car|
							car.app_perfil_id = app_perfil.id
							car.save
						end
						# se migran los EQUIPOS
						per.equipos.each do |equipo|
							equipo.app_administrador_id = app_perfil.id
							equipo.save
						end
						# se migran los PARTICIPACIONES
						if PerEquipo.all.empty?
							per.participaciones.each do |equipo|
								app_perfil.participaciones << equipo
							end
						end
						# se migran los CONTRIBUCIONES
						per.contribuciones.each do |pub|
							pub.app_perfil_id = app_perfil.id
							pub.save
						end
						# se migran los CARGAS
						per.cargas.each do |carga|
							carga.app_perfil_id = app_perfil.id
							carga.save
						end
					end
				end
			end
		end

		# HLP_TUTORIALES

		if ActiveRecord::Base.connection.table_exists? 'hlp_tutoriales'
			if ActiveRecord::Base.connection.table_exists? 'tutoriales'
				Tutorial.all.each do |tut|
					app_tut = HlpTutorial.find_by(tutorial: tut.tutorial)
					if app_tut.blank?
						app_tut = HlpTutorial.create(tutorial: tut.tutorial, detalle: tut.detalle)
					end

					tut.pasos.each do |paso|
						app_tut.hlp_pasos.create(orden: paso.orden, paso: paso.paso, detalle: paso.detalle)
					end
				end
			end
		end

	end

	def inicia_app
		if @perfil.carpetas.empty?
			@perfil.carpetas.create(carpeta: 'Revisar')
			@perfil.carpetas.create(carpeta: 'Excluidas')
			@perfil.carpetas.create(carpeta: 'Postergadas')
			@perfil.carpetas.create(carpeta: 'Revisadas')
		end
	end

end