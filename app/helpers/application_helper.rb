module ApplicationHelper
	## USO GENERAL

	## CAPITAN 

	## ------------------------------------------------------- HOME

	def config_aplicacion(clave)
		Rails.configuration.look_app[:aplicacion][clave]
	end

	def config_portada(clave)
		Rails.configuration.look_app[:aplicacion][:portada][clave]
	end

	def config_init(clave)
		Rails.configuration.look_app[:aplicacion][:init][clave]
	end

	def config_foot(clave)
		Rails.configuration.look_app[:aplicacion][:foot][clave]
	end

	def config_navbar(clave)
		Rails.configuration.look_app[:navbar][clave]
	end

	def c_color(controller)
		if Rails.configuration.look_app[:look_elementos][:help][:controllers].include?(controller)
			Rails.configuration.look_app[:look_elementos][:help][:color]
		elsif Rails.configuration.look_app[:look_elementos][:data][:controllers].include?(controller)
			Rails.configuration.look_app[:look_elementos][:data][:color]
		else
			Rails.configuration.look_app[:look_elementos][:app][:color]
		end
	end

	def objeto_tema_ayuda(tipo)
		TemaAyuda.where(tipo: tipo).any? ? TemaAyuda.where(tipo: tipo).first : nil
	end

	## ------------------------------------------------------- MENU

	# Obtiene los controladores que no despliegan menu
	def nomenu?(controller)
		config_navbar(:nomenu_controllers).include?(controller)
	end

	def item_active(link)
		detalle_link = link.split('/')
		nombre_accion = (detalle_link.length == 2 ? 'index' : detalle_link[2])
		detalle_link[1] == controller_name and nombre_accion == action_name
	end

	def display_item_menu?(item, tipo_item)
		# ITEMS de MENU sólo para USUARIOS REGISTRADOS
		case tipo_item
		when 'admin'
			(usuario_signed_in? and session[:es_administrador] == true)
		when 'usuario'
			usuario_signed_in? and display_item_app(item, tipo_item)
		when 'anonimo'
			true
		when 'dog'
			usuario_signed_in? and session[:perfil_activo]['email'] = 'hugo.chinga.g@gmail.com'
		when 'excluir'
			false
		end
	end

	## ------------------------------------------------------- TABLA

	def config_exceptions_table(clave)
		Rails.configuration.tables[:exceptions][clave]
	end

	def config_tables(clave)
		Rails.configuration.tables[clave]
	end

	# valida el uso de alias en las tablas
	def alias_tabla(controlador)
		Rails.configuration.tables[:alias][controlador].present? ? Rails.configuration.tables[:alias][controlador] : controlador
	end

	# Maneja comportamiento por defecto y excepciones de TABLA
	def in_t?(controlador, label)
		excepcion = false

		if config_exceptions_table(label)[controlador].present?
			elementos = config_exceptions_table(label)[controlador]
			excepcion_self       = (controller_name == controlador and action_name == 'index' and elementos.include?('self'))
			excepcion_todo       = (elementos.include?('*'))
			excepcion_controller = (elementos.include?(controller_name))
			excepcion = (excepcion_self or excepcion_todo or excepcion_controller)
		end
		de = (controller_name == controlador and action_name == 'index') ? Rails.configuration.t_default[label]['self'] : Rails.configuration.t_default[label]['show']

		(excepcion ? (not de) : de)
	end

	def c_tabs(controller)
		if config_tables(:tabs)[controller].present?
			config_tables(:tabs)[controller][controller_name].present? ? config_tables(:tabs)[controller][controller_name] : []
		else
			[]
		end
	end

	def inline_form?(controlador)
		if config_exceptions_table(:inline_form)[controlador].present?
			inline_todos      = config_exceptions_table(:inline_form)[controlador].include?('*')
			inline_controller = config_exceptions_table(:inline_form)[controlador].include?(controller_name)
			inline_todos or inline_controller
		else
			false
		end
	end

	# Objtiene LINK DEL BOTON NEWf
	def get_new_link(controller)
		if config_exceptions_table(:inline_form)[controller].present?
			unless config_exceptions_table(:inline_form)[controller].include?('*') or (config_exceptions_table(:inline_form)[controller].include?('self') and controller == controller_name) or config_exceptions_table(:inline_form)[controller].include?(controller_name)
				tipo_new = 'normal'
			else				
				tipo_new = 'inline_form'
			end
		else
			tipo_new = 'normal'
		end
		if tipo_new == 'normal'
			(alias_tabla(controller_name) == controller or @objeto.blank?) ? "/#{controller}/new" : "/#{@objeto.class.name.tableize}/#{@objeto.id}/#{controller}/new"
		end
	end

	# Obtiene los campos a desplegar en la tabla desde el objeto
	def m_tabla_fields(objeto)
		objeto.class::TABLA_FIELDS
	end

	# Obtiene los estados de un modelo usando el controlador
	# "-tabla.html.erb"
	def c_estados(controller)
		Rails.configuration.x.tables.exceptions[controller][:estados]
	end

	def sortable?(controller, field)
		if Rails.configuration.tables[:sortable][controller].present?
			Rails.configuration.tables[:sortable][controller].include?(field) ? true : false
		else
			false
		end
	end

	def sortable(column, title = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction, html_options: @options}, {:class => css_class}
	end

	## ------------------------------------------------------- TABLA | BTNS

	# pregunta si tiene childs
	# "_btns_e.html.erb"
	def has_child?(objeto)
		# Considera TODO, hasta los has_many through
		objeto.class.reflect_on_all_associations(:has_many).map { |a| objeto.send(a.name).any? }.include?(true)
	end

	## ------------------------------------------------------- FORM & SHOW

	# Manejo de campos condicionales FORM y SHOW
	def filtro_conditional_field?(objeto, field)
		if Rails.configuration.form[:conditional_fields][objeto.class.name].present?
			Rails.configuration.form[:conditional_fields][objeto.class.name].include?(field) ? get_field_condition(objeto, field) : true
		else
			true
		end
	end

	## ------------------------------------------------------- FORM

	def detail_partial(controller)
		if Rails.configuration.form[:detail_types_controller][:help].include?(controller)
			"0help/#{controller.singularize}/detail"
		elsif Rails.configuration.form[:detail_types_controller][:data].include?(controller)
			"0data/#{controller.singularize}/detail"
		elsif Rails.configuration.form[:detail_types_controller][:modelo].include?(controller)
			"#{controller}/detail"
		else
			'0p/form/detail'
		end
	end

	def form_f_detail?(objeto)
		if Rails.configuration.x.form.exceptions[objeto.class.name].present?
			Rails.configuration.x.form.exceptions[objeto.class.name][:f_detail].present? ? Rails.configuration.x.form.exceptions[objeto.class.name][:f_detail] : false
		else
			false
		end
	end

	## -------------------------------------------------------- TABLA & SHOW

	# Obtiene el campo para despleagar en una TABLA
	# Resuelve BT_FIELDS y d_<campo> si es necesario 
	def get_field(label, objeto)
		if objeto.class::column_names.include?(label) or (label.split('_')[0] == 'd') or (label.split('_')[0] == 'm')
			objeto.send(label)
		elsif Rails.configuration.tables[:bt_fields][objeto.class.name].present?
			if Rails.configuration.tables[:bt_fields][objeto.class.name][label].present?
				if objeto.send(Rails.configuration.tables[:bt_fields][objeto.class.name][label]).present?
					objeto.send(Rails.configuration.tables[:bt_fields][objeto.class.name][label]).send(label)
				else
					'Objeto NO Encontrado'
				end
			else
				objeto.send(label)
			end
		else
			'FieldNotFound'
		end
	end

	## ------------------------------------------------------- SHOW

	def config_show(clave)
		Rails.configuration.show[clave]
	end

	def status?(objeto)
		config_show(:status).include?(objeto.class.name)
	end

	# Maneja comportamiento por defecto y excepciones de SHOW
	def in_show?(objeto, label)
		defecto = Rails.configuration.s_default[label]
		(config_show(label).include?(objeto.class.name) ? (not defecto) : defecto)
	end

	# SHOW_TITLE con manejo de excepciones
	# Se usa dentro de la aplicación también
	def show_title(objeto)
		Rails.configuration.show[:show_title].include?(objeto.class.name) ? objeto_title(objeto) : objeto.send(objeto.class.name.tableize.singularize)
	end

	# método de apoyo usado en el método has_many_tabs (arriba)
	def hidden_childs(controller)
		config_show(:hidden)[controller].present? ? config_show(:hidden)[controller] : []
	end

	# Toma las relaciones has_many y les descuenta las HIDDEN_CHILDS
	# "_show.html.erb"
	def has_many_tabs(controller)
		controller.classify.constantize.reflect_on_all_associations(:has_many).map {|a| a.name.to_s} - hidden_childs(controller)
	end

	## ------------------------------------------------------- GENERAL

	# Manejode options para selectors múltiples
	def get_html_opts(options, label, value)
		opts = options.clone
		opts[label] = value
		opts
	end

	## ------------------------------------------------------- LIST

	def text_with_badge(text, badge_value=nil)
	    badge = content_tag :span, badge_value, class: 'badge badge-primary badge-pill'
	    text = raw "#{text} #{badge}" if badge_value
	    return text
	end

	## ------------------------------------------------------- PUBLICACION

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

end
