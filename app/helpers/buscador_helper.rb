module BuscadorHelper

	def letra?(car)
	  car.match?(/[[:alpha:]]/)
	end

	def digito?(car)
	  car.match?(/[[:digit:]]/)
	end

	# Este método muestra que campos están indexados
	def show_indice(publicacion, campo)
		palabras = campo.blank? ? [] : lexer(campo)
		texto_final = ''
		palabras.each do |pal|
			claves_publicacion = publicacion.indices.map {|indice| indice.ind_clave.ind_clave unless indice.ind_clave.blank?}
			if claves_publicacion.include?(pal.downcase)
				ind_palabra = IndPalabra.find_by(ind_palabra: pal.downcase)
				if ind_palabra.ind_sinonimo.blank?
					texto_final = "#{texto_final} <b>#{pal}</b>"
				else
					texto_final = "#{texto_final} <b>['#{pal}]</b>"
				end
			else
				texto_final = "#{texto_final} #{pal}"
			end
		end
		texto_final
	end

	def field_analysis(objeto, field, word)
		unless objeto.send(field).blank?
			objeto.send(field).gsub(/#{word}/i, "<b>[#{word}]</b>").html_safe 
		else
			'Campo no encontrado'
		end
	end

end