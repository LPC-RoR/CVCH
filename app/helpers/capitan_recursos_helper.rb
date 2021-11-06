module CapitanRecursosHelper
	## ------------------------------------------------------- GENERAL

	def app_setup
		{
			nombre: 'CVCh',
			home_link: 'http://www.cvch.cl',
			libre_registro: true,
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

	## ------------------------------------------------------- SIDEBAR

	def app_sidebar_controllers
		[
		]
	end

	## ------------------------------------------------------- TABLA | BTNS

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
				if ActiveRecord::Base.connection.table_exists? 'app_perfiles'
					activo = AppPerfil.find(session[:perfil_activo]['id'])
				else
					activo = Perfil.find(session[:perfil_activo]['id'])
				end
				(objeto.carpetas.ids & activo.carpetas.ids).empty? ? 'default' : 'dark'
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
			controller_name == 'contribuciones' and @tab == 'ingreso'
		when 'areas'
			controller_name == 'recursos'
		when 'categorias'
			controller_name == 'recursos'
		when 'especies'
			false
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
			(not Area::NOT_MODIFY.include?(objeto.area)) and
			controller_name == 'recursos' and
			((session[:es_administrador]) or (session[:perfil_activo]['email'] == 'hugo.chinga.g@gmail.com'))
#			((not Area::NOT_MODIFY.include?(objeto.area)) and controller_name == 'rutas' and ((session[:es_administrador]) or (session[:perfil_activo]['email'] == 'hugo.chinga.g@gmail.com')))
		when 'Instancia'
			false
		when 'Ruta'
			false
		when 'Propuesta'
			false
		when 'Observacion'
			usuario_signed_in? ? (objeto.owner_id == session[:perfil_activo]['id'] or session[:es_administrador]) : false
		when 'Mejora'
			usuario_signed_in? ? (objeto.owner_id == session[:perfil_activo]['id'] or session[:es_administrador]) : false
		when 'Usuario'
			false
		when 'Categoria'
			usuario_signed_in? and objeto.perfil_id == session[:perfil_activo]['id'] or session[:es_administrador] and controller_name == 'recursos'
		when 'Especie'
			false
		else
			if ['TemaAyuda', 'Tutorial', 'Paso'].include?(objeto.class.name)
				(usuario_signed_in? ? session[:es_administrador] : false)
			elsif ['IndClave', 'IndExpresion', 'IndIndice', 'IndPalabra'].include?(objeto.class.name)
				false
			else
				true
			end
		end
	end

	def estados_conditions(objeto)
		false
	end

	def x_conditions(objeto, btn)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Instancia'
			controller_name == 'publicaciones'
		when 'Clasificacion'
			objeto.clasificacion != btn
		when 'Carpeta'
			['publicaciones', 'equipos'].include?(controller_name) and not Carpeta::NOT_MODIFY.include?(objeto.carpeta) and objeto.perfil.id == session[:perfil_activo]['id'].to_i
		when 'Area'
			controller_name == 'publicaciones'
		when 'Ruta'
			@activo.administrador.present? or objeto.perfil.id == @activo.id
		when 'Propuesta'
			@activo.administrador.present? or objeto.perfil.id == @activo.id
		when 'Categoria'
			if controller_name == 'publicaciones' and usuario_signed_in?
				etiqueta = Etiqueta.where(publicacion_id: @objeto.id).find_by(categoria_id: objeto.id)
				mi_categoria = objeto.perfil.id == session[:perfil_activo]['id']
				mi_asignacion = etiqueta.asociado_por == session[:perfil_activo]['id']
				etiqueta_revisada = etiqueta.revisado.blank? ? false : (etiqueta.revisado)
				asignacion_administrativa = Perfil.find(etiqueta.asociado_por).administrador.present?

				case btn
				when 'Desasignar'
					session[:es_administrador] or mi_categoria or mi_asignacion
				when 'Aceptar'
					(session[:es_administrador] or mi_categoria) and (not (mi_asignacion or asignacion_administrativa)) and (not etiqueta_revisada)
				when 'Rechazar'
					(session[:es_administrador] or mi_categoria) and (not (mi_asignacion or asignacion_administrativa)) and (etiqueta_revisada)
				end
			else
				false
			end
		when 'Especie'
			if controller_name == 'publicaciones' and usuario_signed_in?
				etiqueta = Etiqueta.where(publicacion_id: @objeto.id).find_by(especie_id: objeto.id)
				mi_asignacion = etiqueta.asociado_por == session[:perfil_activo]['id']
				etiqueta_revisada = etiqueta.revisado.blank? ? false : (etiqueta.revisado)
				asignacion_administrativa = Perfil.find(etiqueta.asociado_por).administrador.present?

				case btn
				when 'Desasignar'
					session[:es_administrador] or mi_asignacion
				when 'Aceptar'
					session[:es_administrador] and (not (mi_asignacion or asignacion_administrativa)) and (not etiqueta_revisada)
				when 'Rechazar'
					session[:es_administrador] and (not (mi_asignacion or asignacion_administrativa)) and (etiqueta_revisada)
				end
			else
				false
			end
		when 'IndEstructura'
			true
		else
			if ['IndEstructura', 'IndPalabra'].include?(objeto.class.name)
				true
			else
				false
			end
		end
	end

	def x_btns(objeto)
		case objeto.class.name
		when 'Carpeta'
			[['Desasignar', '/desasignar', true]]
		when 'Carga'
			[['Proceso', '/procesa_carga', false]]
		when 'Area'
			[['Desasignar', '/desasignar', true]]
		when 'Equipo'
			[['Eliminar', '/elimina_equipo', true]]
        when 'Instancia'
        	[['Eliminar', '/elimina_instancia', true]]
        when 'Ruta'
        	[['Eliminar', '/elimina_ruta', true]]
        when 'Propuesta'
        	[['Eliminar', '/elimina_propuesta', true]]
        when 'Categoria'
        	[
                ['Desasignar', '/desasignar', true],
                ['Aceptar',    '/aceptar',    true],
                ['Rechazar',   '/rechazar',   true]
        	]
        when 'Especie'
        	[
                ['Desasignar', '/desasignar', true],
                ['Aceptar',    '/aceptar',    true],
                ['Rechazar',   '/rechazar',   true]
        	]
        when 'IndEstructura'
        	[['Proceso', '/procesa_estructura', false]]
        when 'IndPalabra'
        	[['Excluir', '/excluir', true]]
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
