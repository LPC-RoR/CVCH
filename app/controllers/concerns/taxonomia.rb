module Taxonomia
	extend ActiveSupport::Concern

	def especie_a_estructura(especie)
		if especie.publicaciones.empty?
			especie.etiquetas.delete_all
			filo_especie = especie.filo_especie
			especie.delete
			unless filo_especie.blank?
				genero = filo_especie.filo_elemento
				filo_especie.delete
				unless  genero.blank?
					genero.delete if genero.parent.blank?
				end
			end
		elsif especie.filo_sinonimo.present? and especie.filo_especie.present?
			if especie.filo_especie.genero.present? and especie.filo_especie.genero.filo_elemento.blank? and especie.filo_especie.genero.revisar == true
				filo_especie = especie.filo_especie
				filo.especie.especies.delete(especie)
				if filo_especie.parent.present?
					especie_padre = filo_especie.parent
					filo_especie.delete
					genero = especie_padre.filo_elemento
					especie_padre.delete if especie_padre.children.empty?
				else
					genero = filo_especie.filo_elemento
					filo_especie.delete
				end
				genero.delete if genero.filo_especies.empty?
			else
				filo_especie = especie.filo_especie
				if filo_especie.children.empty? and filo_especie.link_fuente.blank?
					filo_especie.especies.delete(especie)
					filo_especie.delete
				end
			end
		else
#			nombre_especie = especie.especie.downcase.strip
#			filo_especie = FiloEspecie.find_by(filo_especie: nombre_especie)
#			if filo_especie.blank?
#				palabras = especie.especie.downcase.split(' ')
#				genero = FiloElemento.find_by(filo_elemento: palabras[0])
#				if genero.blank?
#					orden_id = FiloOrden.find_by(filo_orden: 'Género').id
#					genero = FiloElemento.create(filo_orden_id: orden_id, filo_elemento: palabras[0], revisar: true)
#				end
#				if palabras.length == 2
#					filo_especie = genero.filo_especies.create(filo_especie: nombre_especie)
#					filo_especie.especies << especie
#				else
#					s_filo_especie = "#{palabras[0]} #{palabras[1]}"
#					filo_especie = FiloEspecie.find_by(filo_especie: s_filo_especie)
#					filo_especie = genero.filo_especies.create(filo_especie: s_filo_especie) if filo_especie.blank?

#					sub_especie = FiloEspecie.create(filo_especie: nombre_especie)
#					filo_especie.children << sub_especie
#					sub_especie.especies << especie
#				end
#			else
#				filo_especie.especies << especie
#			end
		end
	end
end