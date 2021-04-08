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

				palabras = frase.split(' ')

				unless [0, 1].include?(palabras.length)
					expresion = estructura.ind_expresiones.find_by(ind_expresion: frase)
					if expresion.blank?
						expresion = estructura.ind_expresiones.create(ind_expresion: frase)
					end
				else
					expresion = nil
				end

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

						expresion.ind_palabras << palabra unless expresion.blank?

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

			letras_no_peritidas or enteros_no_permitidos or exception(palabra)
		end
	end

	def exception(palabra)
		espanol = IndPalabra::E_ESPANOL.include?(palabra)
		ingles = IndPalabra::E_INGLES.include?(palabra)
		numbers = IndPalabra::NUMBERS.include?(palabra)
		exceptions = IndPalabra::EXCEPTIONS.include?(palabra)

		espanol or ingles or numbers or exceptions
	end

	def busqueda_publicaciones(search, modelo)
		palabras = search.split(' ')
		modelo_ids = []
		palabras.each do |palabra|

			ind_palabra = IndPalabra.find_by(ind_palabra: palabra.strip.downcase)
			if excluye_palabra(palabra) or ind_palabra.blank?
				modelo_ids = []
			else
				modelo_ids = ind_palabra.ind_clave.present? ? modelo_ids.union(ind_palabra.ind_clave.ind_indices.where(class_name: modelo).map {|ii| ii.objeto_id}) : []
			end
		end
		publicaciones = modelo.constantize.where(id: modelo_ids)
		publicaciones
	end

	def indexa_registro(objeto)
		modelos_proceso = IndModelo.where(ind_modelo: objeto.class.name)

		modelos_proceso.each do |modelo|
			campos = modelo.campos.split(' ')
			campos.each do |campo|
				procesa_campos_busqueda(modelo.ind_estructura, objeto, campo)
			end
		end
	end

	def desindexa_registro(objeto)
		indices = IndIndice.where(class_name: objeto.class.name).where(objeto_id: objeto.id)
		indices.delete_all
	end

end