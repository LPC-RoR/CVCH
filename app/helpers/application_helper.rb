module ApplicationHelper

	## ------------------------------------------------------- TABLA

	## ------------------------------------------------------- FORM
	# Este helper pergunta si hay un partial con un nombre particular en el directorio del controlador


	## -------------------------------------------------------- TABLA & SHOW

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
