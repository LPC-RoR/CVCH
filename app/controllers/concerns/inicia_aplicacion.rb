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
				lista = SbLista.create(lista: 'Administración', acceso: 'admin', link: '/app_recursos/administracion')
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


				e_3 = elementos.find_by(elemento: 'Menús Laterales')
				if e_3.blank?
					lista.sb_elementos.create(orden: 3, nivel: 1, tipo: 'item', elemento: 'Menús Laterales', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'sb_listas')
				end

				e_4 = elementos.find_by(elemento: 'Tutoriales')
				if e_4.blank?
					lista.sb_elementos.create(orden: 4, nivel: 1, tipo: 'item', elemento: 'Tutoriales', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'hlp_tutoriales')
				end

				e_5 = elementos.find_by(elemento: 'Usuarios')
				if e_5.blank?
					lista.sb_elementos.create(orden: 5, nivel: 1, tipo: 'item', elemento: 'Usuarios', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'usuarios')
				end

				e_6 = elementos.find_by(elemento: 'Home')
				if e_6.blank?
					lista.sb_elementos.create(orden: 6, nivel: 1, tipo: 'list', elemento: 'Home', acceso: 'admin', activo: true, despliegue: nil, controlador: nil)
				end

				e_7 = elementos.find_by(elemento: 'Imágenes')
				if e_7.blank?
					lista.sb_elementos.create(orden: 7, nivel: 2, tipo: 'item', elemento: 'Imágenes', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'h_imagenes')
				end

				e_8 = elementos.find_by(elemento: 'Temas')
				if e_8.blank?
					lista.sb_elementos.create(orden: 8, nivel: 2, tipo: 'item', elemento: 'Temas', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'h_temas')
				end

				e_9 = elementos.find_by(elemento: 'Enlaces')
				if e_9.blank?
					lista.sb_elementos.create(orden: 9, nivel: 2, tipo: 'item', elemento: 'Enlaces', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'h_links')
				end

				e_10 = elementos.find_by(elemento: 'Modelos de Estados')
				if e_10.blank?
					lista.sb_elementos.create(orden: 10, nivel: 2, tipo: 'item', elemento: 'Modelos de Estados', acceso: 'admin', activo: true, despliegue: 'list', controlador: 'st_modelos')
				end
			end

			# LISTA AYUDA
			ayuda = SbLista.find_by(lista: 'Ayuda')
			if ayuda.blank?
				ayuda = SbLista.create(lista: 'Ayuda', acceso: 'admin', link: '/app_recursos/ayuda')
			end
		end		

	end

	def libre_registro
		true
	end

	def inicia_app
	end

end