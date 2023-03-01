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
		s = not str.match(/^\d*s$/).blank?
		km = not str.match(/^\d*km$/).blank?
		no = not str.match(/^\d*°$/).blank?
		cm = not str.match(/^\d*cm$/).blank?
		m2 = not str.match(/^\d*m2$/).blank?
		s or km or no or cm or m2x
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



	# Todos estos métodos administran el proceso de búsqueda, utilizando índices y la estructura de búsqueda

	def procesa_campos_busqueda(estructura, objeto, campo)
		campo_base = objeto.send(campo)

		unless campo_base.blank?

			palabras = lexer(campo_base.downcase.gsub(/\n/, ' '))

			palabras.each do |pal|
				unless excluye_palabra(pal)
					# en esta versión NO usaremos ind_clave para acceder a los índices

					clave = estructura.ind_claves.find_by(ind_clave: pal)
					if clave.blank?
						clave = estructura.ind_claves.create(ind_clave: pal)
					end

					palabra = estructura.ind_palabras.find_by(ind_palabra: pal)
					if palabra.blank?
						palabra = estructura.ind_palabras.create(ind_palabra: pal, ind_clave_id: clave.id)
					end

#					expresion.ind_palabras << palabra unless expresion.blank?

					if clave.ind_indices.where(class_name: objeto.class.name).where(objeto_id: objeto.id).empty?
						clave.ind_indices.create(ind_estructura_id: estructura.id, class_name: objeto.class.name, objeto_id: objeto.id)
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
		# se resuelven las excepciones por idioma
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
			if excluye_palabra(palabra) or ind_palabra.blank?
				# si la palabra debe ser excluida, o no se encuentra dentro de las palabras indexdas, no retorna instancias.
				modelo_ids = []
			else
				# si la palabra está en la estructura, pregunta por la clave
				# si la clave existe, retorna la coolecciń de índices
				# si no retorna una csolección vacía
				modelo_ids = ind_palabra.ind_clave.present? ? modelo_ids.union(ind_palabra.ind_clave.ind_indices.where(class_name: modelo).map {|ii| ii.objeto_id}) : []
			end
		end
		# Finalmente obtiene la colección de 
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