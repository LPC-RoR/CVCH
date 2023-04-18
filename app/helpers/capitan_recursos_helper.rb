module CapitanRecursosHelper
	## ------------------------------------------------------- GENERAL

	def app_setup
		{
			nombre: 'CVCh',
			home_link: 'http://www.cvch.cl',
			logo_navbar: 'logo_navbar.gif'
		}
	end

	def image_size
		{
			portada: nil,
			tema: 'half',
			foot: 'half'
		}
	end

	def font_size
		{
			title: 4,
			title_tema: 1,
			detalle_tema: 6
		}
	end

	def app_color
		{
			app: 'info',
			navbar: 'info',
			help: 'dark',
			data: 'success',
			title_tema: 'info',
			detalle_tema: 'info'
		}
	end

	def image_class
		{
			portada: img_class[:centrada],
			image_tema: img_class[:centrada],
			foot: img_class[:centrada]
		}
	end

	## ------------------------------------------------------- LAYOUTS CONTROLLERS

	def app_sidebar_controllers
		[]
	end

	def app_bandeja_controllers
		[]
#		StModelo.all.order(:st_modelo).map {|st_modelo| st_modelo.st_modelo.tableize}
	end

	## ------------------------------------------------------- SCOPES & PARTIALS

	def app_controllers_scope
		{
			busqueda: ['ind_estructuras', 'ind_palabras']
		}
	end

	def app_scope_controller(controller)
		if app_controllers_scope[:busqueda].include?(controller)
			'busqueda'
		else
			nil
		end
	end

	## ------------------------------------------------------- TABLA | BTNS

	def icon_fields(campo, objeto)
		if objeto.class.name == 'Registro'
			if campo == 'fecha'
				case objeto.tipo
				when 'Informe'
				"bi bi-file-earmark-check"
				when 'Documento'+
				"bi bi-file-earmark-pdf"
				when 'Llamada telefónica'
				"bi bi-telephone"
				when 'Mail'
				"bi bi-envelope-at"
				when 'Reporte'
				"bi bi-file-earmark-ruled"
				end
			end
		end
	end

	def sortable_fields
		{
			'publicaciones' => ['author', 'title', 'doc_type', 'year']
		}
	end

	# En modelo.html.erb define el tipo de fila de tabla
	# Se usa para marcar con un color distinto la fila que cumple el criterio
	def table_row_type(objeto)
		case objeto.class.name
		when 'Publicacion'
			if usuario_signed_in?
				(objeto.carpetas.ids & perfil_activo.carpetas.ids).empty? ? 'default' : 'dark'
			else
				'default'
			end
		else
			'default'
		end
	end

	def app_alias_tabla(controller)
		case controller
		when 'papers'
			'publicaciones'
		when 'contribuciones'
			'publicaciones'
		when 'vistas'
			'publicaciones'
		when 'revisiones'
			'publicaciones'
		else
			controller
		end
	end

	def app_new_button_conditions(controller)
		case controller
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
		else
			true
		end
	end

	def app_crud_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			['ingreso', 'contribucion'].include?(objeto.origen) and controller_name == 'contribuciones'
		when 'Carpeta'
			(not Carpeta::NOT_MODIFY.include?(objeto.carpeta)) and controller_name == 'vistas'
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
			controller_name == 'especies'
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

	def x_conditions(objeto, btn)
		case objeto.class.name
		when 'Ruta'
			@activo.administrador.present? or objeto.perfil.id == @activo.id
		when 'Propuesta'
			@activo.administrador.present? or objeto.perfil.id == @activo.id
		else
			false
		end
	end

	def x_btns(objeto)
		case objeto.class.name
        when 'Ruta'
        	[['Eliminar', '/elimina_ruta', true]]
        when 'Propuesta'
        	[['Eliminar', '/elimina_propuesta', true]]
        else
        	[]
		end		
	end

	def show_link_condition(objeto)
		true
	end

	## ------------------------------------------------------- SHOW

	def app_show_title(objeto)
		case objeto.class.name
		when 'Publicacion'
			objeto.title
		else
			objeto.send(objeto.class.name.tableize.singularize)
		end
	end

end
