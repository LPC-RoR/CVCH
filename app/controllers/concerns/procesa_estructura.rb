module ProcesaEstructura
	extend ActiveSupport::Concern



	def letra?(car)
	  car.match?(/[[:alpha:]]/)
	end

	def digito?(car)
	  car.match?(/[[:digit:]]/)
	end

	def numero?(str)
		not str.split('').map {|car| car.match?(/[[:digit:]]/)}.include?(false)
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

	def p_palabra(estructura, expresion, palabra)
		o_palabra = estructura.ind_palabras.find_by(ind_palabra: palabra.strip)
		o_palabra = estructura.ind_palabras.create(ind_palabra: palabra.strip) if o_palabra.blank?
		expresion.ind_palabras << o_palabra unless expresion.ind_palabras.ids.include?(o_palabra.id)
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

	def p_expresion(estructura, expresion)
		o_expresion = estructura.ind_expresiones.find_by(ind_expresion: expresion.strip)
		o_expresion = estructura.ind_expresiones.create(ind_expresion: expresion.strip) if o_expresion.blank?
		o_expresion
	end

	def p_indice(estructura, objeto, o_palabra)
		o_indice = o_palabra.ind_indices.find_by(class_name: objeto.class.name, objeto_id: objeto.id)
		o_indice = o_palabra.ind_indices.create(class_name: objeto.class.name, objeto_id: objeto.id) if o_indice.blank?
		estructura.ind_indices << o_indice unless estructura.ind_indices.ids.include?(o_indice.id)
		o_indice
	end

	def procesa_campos_busqueda(estructura, objeto, campo)
		# primero que nad recupera el valor del campo
		texto_base = objeto.send(campo)
		# texto base : en minusculas y no tiene saltos de línea
		texto = texto_base.blank? ? nil : objeto.send(campo).downcase.gsub(/\n/, ' ')

		unless texto.blank?
			# 1.- procesa IDEAS
			ideas = extrae_ideas(texto)
			ideas.each do |idea|
				expresiones = extrae_expresiones(idea)
				expresiones.each do |expresion|
					o_expresion = p_expresion(estructura, expresion)

					palabras = lexer(expresion)
					palabras.each do |palabra|
						unless excluye_palabra(palabra)
							o_palabra = p_palabra(estructura, o_expresion, palabra)

							o_indice = p_indice(estructura, objeto, o_palabra)
						end
					end
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
		espanol = IndSet.find_by(ind_set: 'exc_español').set.split(' ').include?(palabra)
		ingles = IndSet.find_by(ind_set: 'exc_ingles').set.split(' ').include?(palabra)
		numeros = IndSet.find_by(ind_set: 'exc_numeros').set.split(' ').include?(palabra)
		excepciones = IndSet.find_by(ind_set: 'exc_app').set.split(' ').include?(palabra)

		espanol or ingles or numeros or excepciones or numero?(palabra) or unidades?(palabra)
	end

	# Metodo que procesa la búsqueda de
	# search: paarámetros de búsqueda
	# modelo: modelo que orienta la búsqueda
	def busqueda_publicaciones(search, modelo)
		# palabras clave: búsqueda!
		palabras = search.split(' ')
		# modelo_ids: arreeglo con las instancias del modelo que coinciden con la búsqueda.
		modelo_ids = []
		# buscamos palabra por palabra
		palabras.each do |palabra|

			# ind_palabra es la donde se accede al índice inverso
			ind_palabra = IndPalabra.find_by(ind_palabra: palabra.strip.downcase)
			unless excluye_palabra(palabra) or ind_palabra.blank?
				# si la palabra está en la estructura, pregunta por la clave
				# si la clave existe, retorna la coolecciń de índices
				# si no retorna una csolección vacía
				modelo_ids = ind_palabra.ind_clave.present? ? modelo_ids.union(ind_palabra.ind_clave.ind_indices.where(class_name: modelo).map {|ii| ii.objeto_id}) : []
				modelo_ids = modelo_ids.union(ind_palabra.ind_indices.ids)
			end
		end
		# Finalmente obtiene la colección de 
		publicaciones = modelo.constantize.where(id: modelo_ids.uniq)
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