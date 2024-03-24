module ApplicationHelper

	## ------------------------------------------------------- TABLA

	def table_types(controller)
		if ['app_directorios', 'app_documentos', 'app_archivos'].include?(controller)
			table_types_base[:borderless]
		else
			table_types_base[:striped]
		end
	end

	# Obtiene los campos a desplegar en la tabla desde el objeto
	def m_tabla_fields(objeto)
		objeto.class::TABLA_FIELDS
	end

	def sortable?(controller, field)
		if sortable_fields[controller].present?
			sortable_fields[controller].include?(field) ? true : false
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

	# Link de un x_btn del modelo de una tabla
	# objeto : objeto del detalle de la tabla
	# accion : url al que hay que sumarle los parámetros}
	# objeto_ref : true => se incluyen parámetros de @objeto
	def link_x_btn(objeto, accion, objeto_ref)
		ruta_raiz = "/#{objeto.class.name.tableize}/#{objeto.id}#{accion}"
		ruta_objeto = (objeto_ref and @objeto.present?) ? "#{(!!accion.match(/\?+/) ? '&' : '?')}class_name=#{@objeto.class.name}&objeto_id=#{@objeto.id}" : ''
		"#{ruta_raiz}#{ruta_objeto}"
	end

	# pregunta si tiene childs
	# "_btns_e.html.erb"
	def has_child?(objeto)
		# Considera TODO, hasta los has_many through
		objeto.class.reflect_on_all_associations(:has_many).map { |a| objeto.send(a.name).any? }.include?(true)
	end

	## ------------------------------------------------------- FORM
	# Este helper pergunta si hay un partial con un nombre particular en el directorio del controlador


	def url_params(parametros)
		params_options = "n_params=#{parametros.length}"
		parametros.each_with_index do |obj, indice|
			params_options = params_options+"&class_name#{indice+1}=#{obj.class.name}&obj_id#{indice+1}=#{obj.id}"
		end
		params_options
	end

	## -------------------------------------------------------- TABLA & SHOW

	# obtiene el nombre del campo puro desde la descripción de TABLA_FIELDS
	def get_field_name(label)
		label.split(':').last.split('#').last
	end

	# Obtiene el campo para despleagar en una TABLA
	# Acepta los sigueintes labels:
	# 1.- archivo:campo : archivo es un campo has_one o belongs_to y campo es el nombre del campo de esa relación
	# 2.- campo : campo es el campo del objeto
	# 3.- i#campo : es un campo que va antecedido de un ícono
	# Resuelve BT_FIELDS y d_<campo> si es necesario 
	def get_field(label, objeto)
		#Debe resolver archivo:k*#campo
		# [archivo, archivo, campo]

		# Variables de la función
		v = label.split(':')               # vector de palabras en label
		archivos = v.slice(0, v.length-1)  # vector que tienen todos los archivos
		nombre = v.last                    # nombre del campo

		# se avanza por los archivos hasta el último
		archivo = objeto
		archivos.each do |arch|
			archivo = archivo.send(arch)
		end

		v_nombre = nombre.split('#')
		campo = v_nombre.last
		prefijos = v_nombre - [v_nombre.last]

		unless archivo.send(campo).blank?
			if ['DateTime', 'Time'].include?(archivo.send(campo).class.name)
				texto_campo = dma(archivo.send(campo))
			elsif prefijos.include?('uf') 
				texto_campo = number_to_currency(archivo.send(campo), unit: 'UF', precision: 2, format: '%u %n')
			elsif prefijos.include?('$')
				texto_campo = number_to_currency(archivo.send(campo), precision: 0, unit: '$', format: '%u %n')
			elsif prefijos.include?('$2')
				texto_campo = number_to_currency(archivo.send(campo), precision: 2, unit: '$', format: '%u %n')
			elsif prefijos.include?('m')
				texto_campo = number_to_currency(archivo.send(campo), precision: "#{archivo.send('moneda') == 'Pesos' ? '0' : '2'}}".to_i, unit: "#{archivo.send('moneda') == 'Pesos' ? '$' : 'UF'}", format: '%u %n')
			else
				texto_campo = archivo.send(campo)
			end
			[texto_campo, prefijos, archivo.send(campo).class.name]
		else
			nil
		end

	end

	## ------------------------------------------------------- SHOW

	def show_title(objeto)
		case objeto.class.name
		when 'SbLista'
			objeto.lista
		when 'SbElemento'
			objeto.elemento
		when 'HlpTutorial'
			objeto.tutorial
		else
			app_show_title(objeto)
		end
	end

	## ------------------------------------------------------- LIST

	def text_with_badge(text, badge_value=nil)
	    badge = content_tag :span, badge_value, class: 'badge badge-primary badge-pill'
	    text = raw "#{text} #{badge}" if badge_value
	    return text
	end

	## ------------------------------------------------------- PUBLICACION

	def get_evaluacion_publicacion(publicacion, item)
		e = perfil_activo.evaluaciones.find_by(aspecto: item, publicacion_id: publicacion.id)
		e.blank? ? '[no evaluado]' : e.evaluacion
	end

	def get_btns_evaluacion(publicacion, item)
		eval_actual = publicacion.evaluaciones.find_by(aspecto: item)
		excluido = eval_actual.blank? ? [] : [eval_actual.evaluacion]
		Publicacion::EVALUACION[item] - excluido
	end

end
