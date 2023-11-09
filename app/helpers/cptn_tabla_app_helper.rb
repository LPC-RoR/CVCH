module CptnTablaAppHelper
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
				if ['equivalentes-filo_sinonimos', 'sinonimos-filo_sinonimos', 'agregados-filo_sinonimos', 'excluidos-filo_sinonimos', 'filo_actualizaciones', 'app_imagenes'].include?(controller)
					false
				else
					true
				end
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
			seguridad_desde('admin')
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
		when 'FiloEspecie'
			case btn
			when 'Eliminar'
				['filo_especies', 'filo_elementos', 'especies'].include?(controller_name) and seguridad_desde('admin')
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

end