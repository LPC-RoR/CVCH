module BuscadorHelper

	def letra?(car)
	  car.match?(/[[:alpha:]]/)
	end

	def digito?(car)
	  car.match?(/[[:digit:]]/)
	end

	# Este método muestra que campos están indexados
	def show_indice(campo)
		palabras = campo.blank? ? [] : lexer(campo)
		texto_final = ''
		palabras.each do |pal|
			ind_palabra = IndPalabra.find_by(ind_palabra: pal.downcase)
			if ind_palabra.blank?
				texto_final = "#{texto_final} #{pal}"
			elsif ind_palabra.ind_sinonimo.blank?
				texto_final = "#{texto_final} <b>#{pal}</b>"
			else
				texto_final = "#{texto_final} <b>['#{pal}]</b>"
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