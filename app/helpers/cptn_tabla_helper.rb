module CptnTablaHelper

#********************************************************************** GENERAL *************************************************************
	def no_th_controllers
		['directorios', 'documentos', 'archivos', 'imagenes'] + app_no_th_controllers
	end

	## ------------------------------------------------------- FORM
	# Este helper encuentra el partial que se debe desplegar como form
	# originalmente todos llegaban a _form
	# ahora pregunta si hay un partial llamado _datail en el directorio de las vistas del modelo
	def detail_partial(controller)
		# partial?(controlller, dir, partial)
		if partial?(controller, nil, 'detail')
			partial_name(controller, nil, 'detail')
		else
			'0p/form/detail'
		end
	end

	# ADMIN AREA
	# condiciones bajo las cuales se despliega una tabla
	def new_button_conditions(controller)
		aliasness = get_controller(controller)
		if ['app_administradores', 'app_nominas', 'hlp_tutoriales', 'hlp_pasos'].include?(aliasness)
				admin?
		elsif ['app_perfiles', 'usuarios', 'ind_palabras', 'app_contactos', 'app_directorios', 'app_documentos', 'app_archivos', 'app_enlaces'].include?(controller)
			false
		elsif ['app_mensajes'].include?(aliasness)
			action_name == 'index' and @e == 'ingreso'
		elsif ['sb_listas'].include?(aliasness)
				admin?
		elsif ['sb_elementos'].include?(aliasness)
				(@objeto.acceso == 'dog' ? dog? : admin?)
		elsif ['st_modelos'].include?(aliasness)
				dog?
		elsif ['st_estados'].include?(aliasness)
				admin?
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
				admin?
		elsif ['AppPerfil', 'Usuario', 'AppMensaje' ].include?(objeto.class.name)
			false
		elsif ['SbLista', 'SbElemento'].include?(objeto.class.name)
			(usuario_signed_in? and seguridad(objeto.acceso))
		elsif ['st_modelos'].include?(controller)
				dog?
		elsif ['st_estados'].include?(controller)
				admin?
		elsif ['AppObservacion', 'AppMejora'].include?(objeto.class.name)
			(usuario_signed_in? and objeto.app_perfil.id == current_usuario.id)
		else
			app_crud_conditions(objeto, btn)
		end
	end

#**********************************************************************   APP   *************************************************************

	def app_crud_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			['ingreso', 'contribucion'].include?(objeto.origen) and controller_name == 'contribuciones'
		when 'Carpeta'
			controller_name == 'carpetas' and objeto.app_perfil.email == perfil_activo.email
		when 'Area'
			(not Area::NOT_MODIFY.include?(objeto.area)) and controller_name == 'recursos' and admin?
		when 'Instancia'
			false
		when 'Ruta'
			false
		when 'Propuesta'
			false
		when 'Categoria'
			(usuario_signed_in? and objeto.perfil_id == perfil_activo.id) or (admin? and controller_name == 'app_recursos')
		when 'Especie'
			false
		when 'FiloElemento'
			['especies', 'filo_elementos'].include?(controller_name)
		when 'FiloEspecie'
			case btn
			when 'Eliminar'
				['filo_especies', 'filo_elementos', 'especies'].include?(controller_name) and admin?
			when 'Editar'
				false
			end
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