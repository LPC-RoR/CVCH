module RecursosHelper
	## ------------------------------------------------------- TABLA | BTNS

	def crud_conditions(objeto)
		case objeto.class.name
		when 'Carga'
			objeto.estado == 'ingreso'
		when 'Publicacion'
			['ingreso', 'contribucion'].include?(objeto.origen)
		when 'Carpeta'
			not Carpeta::NOT_MODIFY.include?(objeto.carpeta) and controller_name == 'carpetas'
		when 'Area'
			not Area::NOT_MODIFY.include?(objeto.area) and controller_name == 'recursos'
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
		when 'TemaAyuda'
			usuario_signed_in? and session[:es_administrador]
		when 'Tutorial'
			usuario_signed_in? and session[:es_administrador]
		when 'Paso'
			usuario_signed_in? and session[:es_administrador]
		end
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
		end
	end

	## ------------------------------------------------------- FORM & SHOW

	# apoyo de filtro_condicional_field? (abajo)
	def get_field_condition(objeto, field)
		case objeto.class.name
		when 'Publicacion'
			objeto.estado != 'publicada'
		when 'Concepto'
			@activo.administrador.present?
		when 'Mensaje'
			field != 'email' or not usuario_signed_in?
		end
	end

	## ------------------------------------------------------- SHOW

	def show_links(objeto)
		case objeto.class.name
		when 'Publicacion'
			[
				['Editar',     [:edit, objeto], (usuario_signed_in? and not ['publicada', 'papelera'].include?(objeto.estado))],
				['Papelera',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=papelera",     ['ingreso', 'duplicado', 'carga', 'formato', 'contribucion'].include?(objeto.estado)],
				['Eliminar',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=eliminado",    ['papelera'].include?(objeto.estado)],
				['Contribuir', "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=contribucion", ['ingreso'].include?(objeto.estado)],
				['Publicar',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=publicada",    (['contribucion', 'carga', 'duplicado', 'formato'].include?(objeto.estado) and not (objeto.doc_type.blank? or objeto.areas.empty?))],
				['Carga',      "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=carga",        (['publicado', 'papelera'].include?(objeto.estado) and objeto.origen == 'carga')],
				['Ingreso',    "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=ingreso",        (['publicado', 'papelera'].include?(objeto.estado) and objeto.origen == 'ingreso')],
				['Múltiple',   "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=multiple",     objeto.estado == 'duplicado'],
				['Corrección', "/publicaciones/estado?publicacion_id=#{objeto.id}&estado=correccion",   (objeto.estado == 'publicada' and usuario_signed_in?)]
			]
		end
	end

end
