module ProcesaEstructura
	extend ActiveSupport::Concern

	def procesa_campos_busqueda(estructura, objeto, campo)
		# TEXTO BASE
		# 1.- Se remplazan "\n" por ' '
		# 2.- Se lleva a un vector con split(' ')
		# 3.- Se procesa el vector para sacar caracteres especiales con 'strip'[ reptilia—squamata—iguanidae ]
		# 4.- Se vuelve a luntar con join(' ')
		# 5.- Se remplaza cualquier puntuación con '|'
		# 6.- Se remplaza ord = 160 y ord = 39
		campo_base = objeto.send(campo)

		unless campo_base.blank?

			texto_base_1 = campo_base.downcase.gsub(/\n/, ' ').split(' ').map {|pal| pal.strip}.join(' ').gsub(/[\.,;–+°¿=*":\/\?\-\(\)]/, '|')
			texto_base = texto_base_1.split('').map {|c| ([160, 39, 8217].include?(c.ord) ? ' ' : c)}.join('').strip

			frases = texto_base.split('|')

			frases.each do |frase|

				expresion = estructura.ind_expresiones.find_by(ind_expresion: frase)
				if expresion.blank?
					expresion = estructura.ind_expresiones.create(ind_expresion: frase)
				end

				palabras = frase.split(' ')
				palabras.each do |pal|

					unless excluye_palabra(pal)

						clave = estructura.ind_claves.find_by(ind_clave: pal)
						if clave.blank?
							clave = estructura.ind_claves.create(ind_clave: pal)
						end

						palabra = estructura.ind_palabras.find_by(ind_palabra: pal)
						if palabra.blank?
							palabra = estructura.ind_palabras.create(ind_palabra: pal, ind_clave_id: clave.id)
						end

						expresion.ind_palabras << palabra

						if clave.ind_indices.where(class_name: objeto.class.name).where(objeto_id: objeto.id).empty?
							clave.ind_indices.create(ind_estructura_id: estructura.id, class_name: objeto.class.name, objeto_id: objeto.id)
						end
					end

				end
			end
		end
	end

	def excluye_palabra(palabra)
		if palabra.blank?
			true
		else
			letras_no_peritidas = (palabra.length == 1 and not (['i', 'o', 'a'].include?(palabra)))

			entero = Integer(palabra) rescue nil
			enteros_no_permitidos = (palabra.length != 4 and (not entero.blank?))

			letras_no_peritidas or enteros_no_permitidos
		end
	end

end