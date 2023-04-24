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
		(get_controller(controller_name) == controller or @objeto.blank?) ? "/#{controller}/new" : "/#{@objeto.class.name.tableize}/#{@objeto.id}/#{controller}/new"
	end

#**********************************************************************   APP   *************************************************************

	def app_no_th_controllers
		[]
	end

	# APP AREA	
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
end