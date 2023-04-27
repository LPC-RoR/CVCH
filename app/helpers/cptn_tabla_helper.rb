module CptnTablaHelper

#********************************************************************** GENERAL *************************************************************
	def no_th_controllers
		['directorios', 'documentos', 'archivos', 'imagenes'] + app_no_th_controllers
	end

	# ADMIN AREA
	# condiciones bajo las cuales se despliega una tabla
	def new_button_conditions(controller)
		aliasness = get_controller(controller)
		if ['app_administradores', 'app_nominas', 'hlp_tutoriales', 'hlp_pasos'].include?(aliasness)
				seguridad_desde('admin')
		elsif ['app_perfiles', 'usuarios', 'ind_palabras', 'app_contactos', 'app_directorios', 'app_documentos', 'app_archivos', 'app_enlaces'].include?(controller)
			false
		elsif ['app_mensajes'].include?(aliasness)
			action_name == 'index' and @e == 'ingreso'
		elsif ['sb_listas'].include?(aliasness)
				seguridad_desde('admin')
		elsif ['sb_elementos'].include?(aliasness)
				(@objeto.acceso == 'dog' ? dog? : seguridad_desde('admin'))
		elsif ['st_modelos'].include?(aliasness)
				dog?
		elsif ['st_estados'].include?(aliasness)
				seguridad_desde('admin')
		else
			app_new_button_conditions(controller)
		end
	end

	# Objtiene LINK DEL BOTON NEW
	def get_new_link(controller)
		# distingue cuando la tabla está en un index o en un show
		(controller_name == get_controller(controller) or @objeto.blank?) ? "/#{get_controller(controller)}/new" : "/#{@objeto.class.name.tableize}/#{@objeto.id}/#{get_controller(controller)}/new"
	end

	def crud_conditions(objeto, btn)
		if ['AppAdministrador', 'AppNomina', 'HlpTutorial', 'HlpPaso'].include?(objeto.class.name)
				seguridad_desde('admin')
		elsif ['AppPerfil', 'Usuario', 'AppMensaje' ].include?(objeto.class.name)
			false
		elsif ['SbLista', 'SbElemento'].include?(objeto.class.name)
			(usuario_signed_in? and seguridad_desde(objeto.acceso))
		elsif ['st_modelos'].include?(controller)
				dog?
		elsif ['st_estados'].include?(controller)
				seguridad_desde('admin')
		elsif ['AppObservacion', 'AppMejora'].include?(objeto.class.name)
			(usuario_signed_in? and objeto.app_perfil.id == current_usuario.id)
		else
			app_crud_conditions(objeto, btn)
		end
	end

#**********************************************************************   APP   *************************************************************

	def app_no_th_controllers
		[]
	end

	def app_new_button_conditions(controller)
		case controller
		when 'ext-carpetas'
			false
		else
			aliasness = get_controller(controller)
			case aliasness
			when 'publicaciones'
				controller_name == 'contribuciones' and @options[:menu] == 'ingreso'
			when 'areas'
				controller_name == 'app_recursos' and dog?
			when 'categorias'
				controller_name == 'app_recursos' and dog?
			when 'especies'
				false
			when 'filo_elementos'
				controller_name == 'especies'
			when 'filo_especies'
				controller_name == 'filo_elementos' and FiloElemento.all.empty?
			else
				true
			end
		end
	end

	def app_crud_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			['ingreso', 'contribucion'].include?(objeto.origen) and controller_name == 'contribuciones'
		when 'Carpeta'
			controller_name == 'carpetas' and objeto.app_perfil.email == perfil_activo.email
		when 'Area'
			(not Area::NOT_MODIFY.include?(objeto.area)) and controller_name == 'recursos' and seguridad_desde('admin')
		when 'Instancia'
			false
		when 'Ruta'
			false
		when 'Propuesta'
			false
		when 'Categoria'
			(usuario_signed_in? and objeto.perfil_id == perfil_activo_id) or (admin? and controller_name == 'app_recursos')
		when 'Especie'
			false
		when 'FiloElemento'
			['especies', 'filo_elementos'].include?(controller_name)
		else
			if ['TemaAyuda', 'Tutorial', 'Paso'].include?(objeto.class.name)
				(usuario_signed_in? ? admin? : false)
			elsif ['IndClave', 'IndExpresion', 'IndIndice', 'IndPalabra'].include?(objeto.class.name)
				false
			else
				true
			end
		end
	end

end