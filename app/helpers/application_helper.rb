module ApplicationHelper
	## USO GENERAL

	# CAPITAN

	# Obtiene los controladores que no despliegan menu
	def nomenu?(controller)
		Configuracion::M_E_CONTROLLERS.include?(controller)
	end

	def frame_titulo(c, a)
		c.classify.constantize::FRAME_TITULO[a]
	end

	# Pregunta si la "accion" del controlador despliega TABS
	# "_frame.html.erb" y "_bi_frame.html.erb"
	def frame_with_tabs?(controlador, accion)
		Configuracion::FRAME_WITH_TABS_CONTROLLERS.include?(controlador) and not controlador.classify.constantize::FRAME_TABS[accion].blank?
	end

	# Obtiene TABS de un controller + action
	def frame_tabs(controller, action)
		controller.classify.constantize::FRAME_TABS[action]
	end

	def bi_frame_selector(controlador, accion)
		controlador.classify.constantize::FRAME_SELECTOR[accion]
	end

	# Pregunta si la "accion" del "recursos_controller" despluega TABLA
	# "_frame.html.erb" y "_bi_frame.html.erb"
	def frame_with_table?(controlador, accion)
		controlador.classify.constantize::FRAME_ACTIONS_TYPE[accion] == 'tabla'
	end

	# Obtiene los TABS de un modelo usando el controlador
	# "-tabla.html.erb"
	def m_tabs(controller)
		controller.classify.constantize::TABS
	end

	# Obtiene los estados de un modelo usando el controlador
	# "-tabla.html.erb"
	def m_estados(controller)
		controller.classify.constantize::ESTADOS
	end

	# valida el uso de alias en las tablas
	def alias_tabla(controller)
		case controller
		when 'papers'
			'publicaciones'
		when 'hijos'
			'conceptos'
		else
			controller
		end
	end

	# Manejode options para selectors múltiples
	def get_html_opts(options, label, value)
		opts = options.clone
		opts[label] = value
		opts
	end

	# Maneja comportamiento por defecto y excepciones de TABLA
	def in_t?(c, label)
		excepcion = false
		# Pregunta si el Controlador TIENE personalizacion
		if Configuracion::T_E_CONTROLLERS.include?(c)
			# Pregunta si LABEL tiene personalizacion
			# ---------------------------------------------  SELF?  ------------------------------------------------
			unless c.classify.constantize::T_EXCEPTIONS[label].blank?         # NO HAY EXCEPCION PARA EL LABEL
				# Verifica 'self', '*' y c
				excepcion = ((controller_name == c and action_name == 'index' and c.classify.constantize::T_EXCEPTIONS[label].include?('self')) or (c.classify.constantize::T_EXCEPTIONS[label].include?('*')) or (c.classify.constantize::T_EXCEPTIONS[label].include?(controller_name)))
			end
		end 
		de = (controller_name == c and action_name == 'index') ? Configuracion::T_DEFAULT[label]['self'] : Configuracion::T_DEFAULT[label]['show']

		(excepcion ? (not de) : de)
	end

	def inline_form?(c)
		Configuracion::T_E_NEW_CONTROLLERS.include?(c) ? (c.classify.constantize::T_NEW_EXCEPTIONS['*'] == 'inline' or c.classify.constantize::T_NEW_EXCEPTIONS[controller_name] == 'inline') : false
	end

	# Maneja comportamiento por defecto y excepciones de SHOW
	def in_show?(objeto, label)
		excepcion = false
		# Pregunta si el Modelo TIENE personalizacion
		if Configuracion::S_E_MODELS.include?(objeto.class.name)
			# Pregunta si LABEL tiene personalizacion
			excepcion = objeto.class::S_E.include?(label)
		end 

		de = Configuracion::S_DEFAULT[label]
		(excepcion ? (not de) : de)
	end

	# SHOW_TITLE con manejo de excepciones
	# Se usa dentro de la aplicación también
	def show_title(object)
		if Configuracion::S_E_TITLE_MODELS.include?(object.class.name)
			object.show_title
		else
			"#{object.send(object.class.name.downcase)}"
		end
	end

	# Obtiene los campos a desplegar en la tabla desde el objeto
	def m_tabla_fields(objeto)
		objeto.class::TABLA_FIELDS
	end

	# despliegue de RUT
	# Lo dejo porque no tengo claro como lo reemplace
#	def d_rut(rut)
#		rut_base = rut.tr('.-', '').length == 8 ? '0'+rut.tr('.-', '') : rut.tr('.-', '')
#		rut_base.reverse.insert(1, '-').insert(5, '.').insert(9, '.').reverse
#	end


	# Toma las relaciones has_many y les descuenta las HIDDEN_CHILDS
	# "_show.html.erb"
	def has_many_tabs(controller)
		controller.classify.constantize.reflect_on_all_associations(:has_many).map {|a| a.name.to_s} - hidden_childs(controller)
	end

	# método de apoyo usado en el método has_many_tabs (arriba)
	def hidden_childs(controller)
		Configuracion::HIDDEN_CHILDS_CONTROLLERS.include?(controller) ? controller.classify.constantize::HIDDEN_CHILDS : []
	end

	# pregunta si tiene childs
	# "_btns_e.html.erb"
	def has_child?(objeto)
		# Considera TODO, hasta los has_many through
		objeto.class.reflect_on_all_associations(:has_many).map { |a| objeto.send(a.name).any? }.include?(true)
	end

	# Objtiene LINK DEL BOTON NEW
	def get_new_link(controller)
		# CONTROLA EXCEPCIONES
		if Configuracion::T_E_NEW_CONTROLLERS.include?(controller)
			if controller.classify.constantize::T_NEW_EXCEPTIONS['*'].present?
				tipo_new = controller.classify.constantize::T_NEW_EXCEPTIONS['*']
			else
				if (controller_name == controller and controller.classify.constantize::T_NEW_EXCEPTIONS['self'].present?)
					tipo_new = controller.classify.constantize::T_NEW_EXCEPTIONS['self']
				elsif controller.classify.constantize::T_NEW_EXCEPTIONS[controller_name].present?
					tipo_new = controller.classify.constantize::T_NEW_EXCEPTIONS[controller_name]
				else
					tipo_new = 'normal'
				end
			end
		else
			tipo_new = 'normal'
		end
		# GENERA EL LINK
		case tipo_new
		when 'mask'
			"/#{controller}/mask_new?origen=#{controller_name}"
		# TIPO_NEW = 'child_nuevo'
		# {'pedidos'}
		when 'child_nuevo'
			"/#{controller}/nuevo?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'child_sel' : seleccion ? parametro_padre
		# {'empleados', 'productos', 'clientes(*)'}
		when 'child_sel'
			# TIPO_NEW = 'child_sel'
			# TABLA_SEL = 'controller'
			"/#{controller.classify.constantize::TABLA_SEL}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}"
		# TIPO_NEW = 'detalle_pedido' : seleccion ? parametro_padre & empresa
		# {'empleados', 'productos', 'clientes(*)'}
		when 'detalle_pedido'
			"/#{controller.classify.constantize::SELECTOR}/seleccion?#{@objeto.class.name.downcase}_id=#{@objeto.id}&empresa_id=#{@objeto.registro.empresa.id}"
		when 'normal'
			f_controller(controller_name) == controller ? "/#{controller}/new" : "/#{@objeto.class.name.tableize}/#{@objeto.id}/#{controller}/new"
		end
	end

	# Método de apoyo usado en get_new_link (arriba)
	def f_controller(controller)
		case controller
		when 'contribuciones'
			'publicaciones'
		else
			controller
		end
	end

	# Corrige palabras
	# "_title.html.erb"
	def corrige(w)
		case w
		when 'Controlador'
			'label'
		else
			w.capitalize
		end
	end

	# manejo de f_tabla para manejar tablas asociadas
	def f_tabla(objeto)
		objeto.send(objeto.class::F_TABLA.singularize)
	end

	# Obtiene el campo para despleagar en una TABLA
	# Resuelve BT_FIELDS y d_<campo> si es necesario 
	def get_field(name, objeto)
		if objeto.class::column_names.include?(name) or (name.split('_')[0] == 'd') or (name.split('_')[0] == 'm')
			objeto.send(name)
		elsif objeto.class::BT_FIELDS.include?(name)
			o_bt = objeto.send(objeto.class::BT_MODEL)
			o_bt.send(name)
		else
			'FieldNotFound'
		end
	end

	def get_evaluacion_publicacion(publicacion, item)
		@activo = Perfil.find(session[:perfil_activo]['id'])
		e = @activo.evaluaciones.find_by(aspecto: item, publicacion_id: publicacion.id)
		e.blank? ? '[no evaluado]' : e.evaluacion
	end

	def get_btns_evaluacion(publicacion, item)
		eval_actual = publicacion.evaluaciones.find_by(aspecto: item)
		excluido = eval_actual.blank? ? [] : [eval_actual.evaluacion]
		Publicacion::EVALUACION[item] - excluido
	end

	# método de apoyo para filtro_self_filed? (abajo)
	def my_objeto?(objeto)
		case objeto.class.name
		when 'Equipo'
			objeto.perfil.id == session[:perfil_activo]['id']
		end
	end

	# Esto es importante para diferenciar OBJETOS PROPIOS
	def filtro_self_field?(objeto, field)
		if Configuracion::MODELS_WITH_SELF_FIELDS.include?(objeto.class.name)
			objeto.class::MY_FIELDS.include?(field) ? (my_objeto?(objeto) ? true : false) : true
		else
			true
		end
	end

	# Manejo de campos condicionales
	def filtro_conditional_field?(objeto, field)
		if Configuracion::FORM_CONDITIONAL_FIELDS_MODELS.include?(objeto.class.name)
			objeto.class::FORM_CONDITIONAL_FIELDS.include?(field) ? objeto.send("c_#{field}") : true
		else
			true
		end
	end

	# Metodo de apoyo para despliega_btns? (abajo)
	def coleccion_propia?
		Configuracion::COLECCIONES_PROPIAS.include?("#{controller_name}##{action_name}")
	end
	# Metodo de apoyo para despliega_btns? (abajo)
	def objeto_propio?(objeto)
		if Configuracion::OBJETOS_PROPIOS.include?("#{controller_name}##{action_name}")
			true
		else
			case objeto.class.name
			when 'Publicacion'
				# Propio por ahora
				# Hay que ser usuario administrador
				true
			when 'Equipo'
				objeto.administrador.id == session[:perfil_activo]['id']
			when 'Carpeta'
				objeto.equipo.present? ? objeto.equipo.perfil.id == session[:perfil_activo]['id'] : objeto.investigador.id == session[:perfil_activo]['id']
			else
				false
			end
		end
	end

	# Metodo de apoyo para despliega_btns? (abajo)
	def m_despliega_btns?(objeto)
		Configuracion::T_E_LINE_BTNS_MODELS.include?(objeto.class.name) ? objeto.btns_control : true
	end

	# pregunta cuando se despliegan btns
	def despliega_btns?(objeto)
		coleccion_propia? ? m_despliega_btns?(objeto) : (objeto_propio?(objeto) and m_despliega_btns?(objeto))		
	end

	# pregunta cuando se despliegan x_btns
	def x_btns?(objeto)
		Configuracion::T_E_ADDITIONAL_BTNS_MODEL.include?(objeto.class.name)
	end


	def text_with_badge(text, badge_value=nil)
	    badge = content_tag :span, badge_value, class: 'badge badge-primary badge-pill'
	    text = raw "#{text} #{badge}" if badge_value
	    return text
	end

	def display_item_menu?(item)
		# ITEMS de MENU sólo para USUARIOS REGISTRADOS
		if Configuracion::M_I_SIGN_IN.include?(item)
			usuario_signed_in?
		elsif Configuracion::M_I_ADMIN.include?(item)
			(usuario_signed_in? and session[:es_administrador] == true)
		elsif Configuracion::M_I_ANONIMOS.include?(item)
			true
		end
	end
end
