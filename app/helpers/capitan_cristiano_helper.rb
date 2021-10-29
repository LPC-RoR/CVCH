module CapitanCristianoHelper

	## ------------------------------------------------------- CRISTIANO BASE
	def cristiano(text, origen, destino)
		if ['AppAdministrador', 'app_administradores'].include?(text)
			'Administrador'
		elsif ['AppNomina', 'app_nominas'].include?(text)
			'Nómina'
		elsif ['AppPerfil', 'app_perfiles'].include?(text)
			'Perfil'
		elsif ['AppObservacion', 'app_observaciones'].include?(text)
			'Observación'
		elsif ['AppMejora', 'app_mejoras'].include?(text)
			'Mejora'
		elsif ['SbLista', 'sb_listas'].include?(text)
			'Menú lateral'
		elsif ['SbElemento', 'sb_elementos'].include?(text)
			'Elemento menú lateral'
		elsif ['HlpTutorial', 'hlp_tutoriales'].include?(text)
			'Tutorial'
		elsif ['HlpPaso', 'hlp_pasos'].include?(text)
			'Paso'
		else
			cristiano_app(text, origen, destino)
		end
	end

	def cristiano_app(text, origen, destino)
		if ['doc_type'].include?(text)
			'Type'
		else
			case origen
			when 'field'
				case destino
				when 'singular'
					text.humanize
				when 'plural'
				end
			when 'class'
				case destino
				when 'singular'
					text.tableize.humanize.singularize
				when 'plural'
				end
			when 'controller'
				case destino
				when 'singular'
					text.humanize.singularize
				when 'plural'
				end
			else
				text
			end
		end
	end

end