module ProcesaEstructura
	extend ActiveSupport::Concern


	def letra?(car)
	  car.match?(/[[:alpha:]]/)
	end

	def digito?(car)
	  car.match?(/[[:digit:]]/)
	end

	def numero?(str)
		!!(str =~ /\A[-+]?[0-9]+\z/)
	end

	def unidades?(str)
		set = IndSet.find_by(ind_set: 'unidades')
		unidades = set.set.split(' ')
		blank = true
		unidades.each do |unidad|
			no_coincidencia = str.match(/^\d*#{unidad}$/).blank?
			blank = (blank and no_coincidencia)
		end
		blank ? false : true
	end

	def lexer(campo)
		llaves = []
		palabra = ''
		tipo = nil
		caracteres = campo.split('')
		caracteres.each do |car|
			if letra?(car)
				palabra += car
				tipo = 'alpha'
			elsif digito?(car)
				palabra += car
				tipo = 'number' if tipo.blank?
			elsif car == ' '
				unless tipo.blank?
					llaves << palabra
					palabra = ''
					tipo = nil
				end
			else
				unless tipo.blank?
					llaves << palabra
					palabra = ''
					tipo = nil
				end
			end
		end
		
		llaves << palabra unless palabra.blank?
		llaves
	end

	def p_palabra(estructura, palabra)
		o_palabra = estructura.ind_palabras.find_by(ind_palabra: palabra.strip)
		o_palabra = estructura.ind_palabras.create(ind_palabra: palabra.strip) if o_palabra.blank?
		o_palabra
	end


	# Todos estos métodos administran el proceso de búsqueda, utilizando índices y la estructura de búsqueda
	def extrae_ideas(texto)
		reemplazos = { '.' => '|', '¿' => '|', '?' => '|', '¡' => '|', '!' => '|' }
		ideas_marcadas = texto.gsub(Regexp.union(reemplazos.keys), reemplazos)
		ideas_marcadas.split('|')
	end

	def extrae_expresiones(texto)
		reemplazos = { ',' => '|', ';' => '|', ':' => '|', '(' => '|', ')' => '|', '[' => '|', ']' => '|', '{' => '|', '}' => '|', 'º' => '|' }
		exp_marcadas = texto.gsub(Regexp.union(reemplazos.keys), reemplazos)
		exp_marcadas.split('|')
	end

	def p_indice(estructura, objeto, o_palabra)
		o_indice = o_palabra.ind_indices.find_by(class_name: objeto.class.name, objeto_id: objeto.id)
		o_indice = o_palabra.ind_indices.create(class_name: objeto.class.name, objeto_id: objeto.id) if o_indice.blank?
			o_indice
	end

	def palabras_texto(str)
		limpio = str.gsub(/\t|\r|\n/, ' ').strip.downcase
		limpio.gsub(/[\.,;\:\(\)¿\?¡!\[\]\{\}°º\"\'\#\%\&$\*\+\-\\\/´’′ ʼ±–‰−²^”‘˗—·␣◦  =~\<\>_¢ |“˚×½‐􀃛@`ª]/, ' ').split(' ').map {|word| word.strip}
	end

	def procesa_campos_busqueda(estructura, objeto, campo)
		# primero que nada recupera el valor del campo
		texto_campo = objeto.send(campo)
		# texto base : en minusculas y no tiene saltos de línea
		palabras = texto_campo.blank? ? nil : palabras_texto(texto_campo)

		unless texto_campo.blank?
			palabras.each do |palabra|
				unless excluye_palabra(palabra)
					o_palabra = p_palabra(estructura, palabra)

					o_indice = p_indice(estructura, objeto, o_palabra)
				end
			end
		end
	end

	# Este método verifica si una palabra clave de la búsqueda debe o no ser excluida.
	def excluye_palabra(palabra)
		palabra.blank? ? true : exception(palabra)
	end

	def exception(palabra)
		# se resuelven l'as excepciones por idioma
		# En versión nueva estaas se encuentran en IndSet
#		espanol = IndSet.find_by(ind_set: 'exc_español').set.split(' ').include?(palabra)
#		ingles = IndSet.find_by(ind_set: 'exc_ingles').set.split(' ').include?(palabra)
#		numeros = IndSet.find_by(ind_set: 'exc_numeros').set.split(' ').include?(palabra)
#		excepciones = IndSet.find_by(ind_set: 'exc_app').set.split(' ').include?(palabra)

		excepcion = false

		IndSet.where(tipo: 'exclusion').each do |exclusion|
			excepcion = exclusion.set.split(' ').include?(palabra) unless excepcion
		end

		excepcion or numero?(palabra) or unidades?(palabra)
	end

	def order_string(field_name, arr)
	  arr.map { |val| "#{field_name}=#{val} desc" }.join(', ')
	end

	# Metodo que procesa la búsqueda de
	# search: paarámetros de búsqueda
	# modelo: modelo que buscamos (Publicacion)
	def busqueda_publicaciones(search, modelo)
		# palabras clave: búsqueda!
		palabras = palabras_texto(search)
		# modelo_ids: arreeglo con las instancias del modelo que coinciden con la búsqueda.
		modelo_ids = []
		# buscamos palabra por palabra
		palabras.each do |palabra|

			unless excluye_palabra(palabra.strip.downcase)
				# ind_palabra es la donde se accede al índice inverso
				ind_palabra = IndPalabra.find_by(ind_palabra: palabra.strip.downcase)
				unless ind_palabra.blank?
					# si la palabra está en la estructura, pregunta por la clave
					# si la clave existe, retorna la colección de índices
					# si no retorna una csolección vacía

					modelo_ids = ind_palabra.ind_clave.present? ? modelo_ids.union(ind_palabra.ind_clave.ind_indices.where(class_name: modelo).map {|ii| ii.objeto_id}) : []
					modelo_ids = modelo_ids.union(ind_palabra.ind_indices.ids)

				end
			end 
		end

		# seguro hay una forma más simple, pero es la que encontré usando la consola
		ids_ordenados = modelo_ids.group_by {|n| n}.map {|e| e}.sort_by {|e| -e[1].length}.map {|e| e[0].to_i}

		# Finalmente obtiene la colección de 
		publicaciones = modelo.constantize.where(id: ids_ordenados).order(order_string('id', ids_ordenados))
		publicaciones
	end

	# esta función funcionaa si hay una única estructura de de búsqueda
	def indexa_registro(objeto)
		modelos_proceso = IndModelo.where(ind_modelo: objeto.class.name)

		modelos_proceso.each do |modelo|
			campos = modelo.campos.split(' ')
			campos.each do |campo|
				procesa_campos_busqueda(modelo.ind_estructura, objeto, campo)
			end
		end
	end

	# esta función funcionaa si hay una única estructura de de búsqueda
	def desindexa_registro(objeto)
		indices = IndIndice.where(class_name: objeto.class.name, objeto_id: objeto.id)
		indices.delete_all
	end

end