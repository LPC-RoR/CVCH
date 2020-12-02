class ApplicationController < ActionController::Base
	def archivo_usuario(email)
		email.split('@').join('-').split('.').join('_')
	end

	def carga_archivo_excel(carga)
		require 'roo'
		require 'json'
		require 'yaml'

		xlsx = Roo::Spreadsheet.open(carga.archivo)

		# tomamos el AREA desde afuera para evitar errores.
		@area = carga.area

		xlsx.each() do |hash|
			@author = ''
			@doi = ''
			@volume = ''
			@pages = ''
			@journal = ''
			@titulo = ''
			@doc_type = ''
			# hash[0] Primera columna, aqui no la usamos
			# hash[1] year, lo usamos para verificar
			# hash[2] quote, esta es la CITA
			@year = hash[1]
			# sanitizamos tags html
			@cita = CGI.unescapeHTML(ActionView::Base.full_sanitizer.sanitize(hash[2]))

			m=@cita.match(/(?<author>[ÁÉÍÓÚA-Z\-\s,Ñ&]*) \((?<year>[^\)]*)\)\n*\s*(?<resto>.*)/)
			@author = m[:author].strip
			@year = m[:year].strip
			@resto = m[:resto].strip

			if !!@resto.match(/doi.org/)
				@doi = @resto.split('http')[1].split('.org/')[1]
				@resto_2 = @resto.split('http')[0]
			elsif !!@resto.match(/\sdoi:/)
				@doi = @resto.split(' doi:')[1]
				@resto_2 = @resto.split(' doi:')[0]
			else
				@resto_2 = @resto
			end

			if !!@resto_2.match(/(?<resto3>.*) (?<volume>\d*\(*\d*\)*):(?<pages>\s*\d*-*\d*).$/)
				m2 = @resto_2.match(/(?<resto3>.*) (?<volume>\d*\(*\d*\)*):(?<pages>\s*\d*-*\d*).$/)
				@resto_3 = m2[:resto3].strip
				@volume = m2[:volume].strip
				@pages = m2[:pages].strip
				@doc_type = 'article'
				unless @resto_3.split('.').length == 1
					@journal = @resto_3.split('.').last.strip
					@titulo = @resto_3.split(@journal)[0].strip.delete_suffix('.')
				end
			else
				m2 = ''
				@resto_3 = ''
			end
			# usamos estado == 'carga' para diferenciar en el proceso de revisión lo que viene de una carga de lo que viene de un ingreso
			# ambas opciones tienen distinto despliegue al momento de revisar.
			@estado = 'carga'
			@origen = 'carga'
			pub = Publicacion.create(origen: @origen, estado: @estado, doc_type: @doc_type, d_quote: @cita, author: @author, year: @year, doi: @doi, volume: @volume, pages: @pages, d_journal: @journal, title: @titulo)
			carga.publicaciones << pub
			@area.papers << pub
		end
	end

	def procesa_cita_carga(cita)

		# Procesa Area
		# Se suspende porque se hace conla carga

		# Procesa Autores
		authors = []
		last_author = cita.author.split('&').last
		prev_authors = cita.author.split('&')[0].split(',')
		prev_authors.each_with_index  do |val, index|
			author_with_format = (index == 0 ? (val.split(' ')[1]+' '+val.split(' ')[0]) : val.strip)
			authors << author_with_format
		end
		authors << last_author

		authors.each do |aut|
			inv = Investigador.find_by(investigador: aut)
			if inv.blank?
				inv = Investigador.create(investigador: aut)
			end
			cita.investigadores << inv
		end

		# Procesa Revista
		# Se usa 'd_journal' porque en Publicacion sólo se usa revista_id
		rev = Revista.find_by(revista: cita.d_journal)
		if rev.blank?
			rev = Revista.create(revista: cita.d_journal)
		end
		rev.publicaciones << cita
	
	end

	def limpia_autor_ingreso(autor)
		autor_limpio = ''
		autor.strip.split('').each do |c|
			if !!c.match(/[a-zA-ZáéíóúàèìòùäëïöüÁÉÍÓÚÀÈÌÒÙÄËÏÖÜ\.\-,&\s]/)
				autor_limpio += c
			end
		end
		autor_con_coma = autor_limpio.split(' and ').join(',').split('&').join(',')
		elementos = autor_con_coma.split(',').map {|n| n.strip}
		autores = []
		elementos.each do |a|
			unless a.strip.split(' ').length < 2
				partes = a.strip.split(' ')
				if partes.last.length == 1
					partes.pop
					autores << partes.join(' ')
				else
					autores << a
				end
			end
		end
		last = autores.last
		autores.pop
		case autores.length
		when 0
			last
		when 1
			autores[0]+' & '+last
		else
			autores.join(', ')+' & '+last
		end
	end

	# VERIFICA CARGA
	# 1. Verifica que ya haya sido cargada
	# 2. Si ya ha sido cargada, puede ser una versión más completa
	# VERIFICA INGRESOS
	# 1. Verifica por DOI
	# 2. Verifica por Nombre de la publicación
	def unicidad_publicacion_carga(hash_articulo)
		# VERIFICA CARGA
		c = Publicacion.find_by(unique_id: hash_articulo['Unique-ID']) 
		unless c.blank?
			# LO ENCONTRÖ HAY QUE VER SI ESTÁ EN ALGUNA DE MIS CARPETAS
			my_self = Investigador.find(session[:paerfil]['id'])
			if p.carpetas.ids.intersection(my_self.carpetas.ids).empty?
				'sin carpeta'
			else
				c.year.blank? ? 'remplazar_carga' : 'saltar'
			end
		else
			# NO ENCONTRADO EN CARGA buscamos por DOI
			i = Publicacion.find_by(doi: hash_articulo['DOI'])
			if i.blank? or hash_articulo['DOI'].blank?
				# NO LO ENCONTRO POR DOI -> Preguntar por TITULO
				t = Publicacion.find_by(title: hash_articulo['Title'])
				t.blank? ? 'nuevo' : 'colision_titulo'
			else
				# LO ENCONTRO POR DOI
				'remplazar_doi'
			end
		end
	end

	# PROCESA EDITORIAL (INGRESO)
	def procesa_editorial(detalle_editorial)
		if !!detalle_editorial.match(/^(?<journal>[a-zA-Z\s]*) \((?<year>\d{4})\) (?<volume>\d*), (?<pages>\d*–\d*)/)
			grupos = detalle_editorial.match(/^(?<journal>[a-zA-Z\s]*) \((?<year>\d{4})\) (?<volume>\d*), (?<pages>\d*–\d*)/)
			# "(2019) 4, 234-567"
		elsif detalle_editorial.match(/(?<journal>[a-zA-Z\s]*) (?<volume>\d*) \((?<year>\d{4})\) (?<pages>\d*[–\s]+\d*)/)
			grupos = detalle_editorial.match(/(?<journal>[a-zA-Z\s]*) (?<volume>\d*) \((?<year>\d{4})\) (?<pages>\d*[–\s]+\d*)/)
			# "103 (2011) 102-412"
		elsif detalle_editorial.match(/(?<journal>[a-zA-Z\s]*) \((?<year>\d{4})\) (?<volume>\d*):(?<pages>\d*–\d*)/)
			# "(2014) 43:399-408"
			grupos = detalle_editorial.match(/(?<journal>[a-zA-Z\s]*) \((?<year>\d{4})\) (?<volume>\d*):(?<pages>\d*–\d*)/)
		end
	end
	# PROCESA AUTORES (INGRESO)
	def procesa_autores(detalle_autores)
		st = 0
		resultado = []
		nombre = ''
		llave = []
		ant = ''
		detalle_autores.strip.split('').each do |c|
			case st
			when 0 # INICIO
				if c.match(/[a-z1-9]/) # llave?
					llave << c
					st = 1 
				elsif c.match(/[A-Z]/) # inicio nombre?
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 1 # LLAVE
				if c.match(/\s/) # fin llave?
					st = 2
				elsif c.match(/,/) # otra llave
					st = 0
				else # FATAL
					st = 100
				end
			when 2 # FIN LLgAVE?
				if c.match(/\s/) # consume espacios
				elsif c.match(/,/) # otra llave
					st = 0
				elsif c.match(/[A-Z]/) # Inicio Nombre
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 3 # NOMBRE
				if c.match(/[a-zA-Z]/) # completa nombre
					nombre += c
				elsif c.match(/\s/) # fin nombre
					nombre += c
					st = 4
				else # FATAL
					st = 100
				end
			when 4 # FIN NOMBRE
				if c.match(/\s/) # consume espacios
				elsif c.match(/[A-Z]/) # inicio Inicial/Apellido?
					nombre += c
					st = 5
				elsif c.match(/[a-z]/) # apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 5 # INICIO INICIAL/APELLIDO
				if c.match(/\./) #/ inicial
					nombre += c
					st = 6
				elsif c.match(/\s/) # fin Inicial (AGREGAR A AUTOMATA)
					nombre += c
					st = 8
				elsif c.match(/[a-zA-Z]/) # Apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 6 # . INICIAL
				if c.match(/[A-Z]/) # Inicial
					nombre += c
					st = 7
				elsif c.match(/\s/) # fin Inicial
					nombre += c
					st = 8
				else # FATAL
					st = 100
				end
			when 7 # INICIAL
				if c.match(/\./) # . Inicial
					nombre += c
					st = 6
				elsif c.match(/\s/) # fin Inicial
					nombre += c
					st = 8
				else # FATAL
					st = 100
				end
			when 8 # FIN INICIAL
				if c.match(/\s/) # consume espacios
				elsif c.match(/[a-zA-Z]/) # Inicio Apellido
					nombre += c
					st = 10
				else # FATAL
					st = 100
				end
			when 10 # APELLIDO
				if c.match(/[a-zA-Z]/) # completa apellido
					nombre += c
				elsif c.match(/[1-9]/) # llave
					llave << c
					st = 11
				elsif c.match(/\s/) # fin apellido?
					# nombre += c					
					st = 15
				elsif c.match(/a/) # a de 'and' (AGREGAR A AUTOMATA)
					st = 16
				else # FATAL
					st = 100
				end
			when 11 # LLAVE
				if c.match(/\s/) # fin llave?
					st = 12
				elsif c.match(/,/) # fin nombre?
					st = 13
				else # FATAL
					st = 100
				end
			when 12 # FIN LLAVE?
				if c.match(/\s/) # ahi mismo
				elsif c.match(/,/) # fin nombre?
					st = 13
				elsif c.match(/a/) # a de 'and'
					st = 16
				elsif c.match(/&/) # fin de palabra
					resultado << [nombre, llave]
					nombre = c
					llave = []
					st = 19
				else # FATAL
					st = 100
				end
			when 13 # FIN NOMBRE?
				if c.match(/[,\s]/) # consume espacios (COMPLETAR AUTOMATA)
				elsif c.match(/[a-z1-9\*]/) or c.ord == 8727 # llave (COMPLETAR AUTOMATA)
					llave << c
					st = 11 
				elsif c.match(/[A-Z]/) # Inicio Nombre
					resultado << [nombre, llave]
					nombre = c
					llave = []
					st = 3
				else # FATAL
					st = 100
				end
			when 15 # FIN APELLIDO
				if c.match(/\s/) # consume espacios
				elsif c.match(/[1-9]/) # key
					llave << c
					st = 11
				elsif c.match(/a/) # a letra de 'and'???
					st = 16
				elsif c.match(/[b-z]/) # llave/apellido?
					ant = c
					st = 20
				elsif c.match(/[A-Z]/) # Sigue el apellido (COMPLETAR AUTOMATA)
					nombre += ' '+c
					st = 10
				elsif c.match(/[,&]/) # Fin Nombre
					resultado << [nombre, llave]
					nombre = ''
					llave = []
					st = 19
				else # FATAL
					st = 100
				end
			when 16 # 'a' DE 'and'/LLAVE/APELLIDO
				if c.match(/\s/) # fin llave
					llave << 'a'
					st = 12
				elsif c.match(/,/) # Fin Nombre?
					llave << 'a'
					st = 13
				elsif c.match(/[a-mo-z]/) # apellido
					nombre += 'a'+c
					st = 10
				elsif c.match(/n/) # n de 'and'
					st = 17
				else # FATAL
					st = 100
				end
			when 17 # 'n' DE 'and'/APELLIDO?
				if c.match(/d/) # d de 'and'
					st = 18
				elsif c.match(/[a-ce-z]/) # apellido
					nombre += 'an'+c
					st = 10
				else # FATAL
					st = 100
				end
			when 18 # 'd' DE 'and'/ APELLIDO
				if c.match(/\s/) # fin de 'and'
					resultado << [nombre, llave]
					nombre = ''
					llave = []
					st = 19
				elsif c.match(/[a-z]/) # apellido
					nombre += 'and'+c
					st = 10
				else # FATAL
					st = 100
				end
			when 19 # FIN NOMBRE COMPLETO
				if c.match(/\s/) # se queda ahí
				elsif c.match(/[A-Z]/) # Inicio de Nombre
					nombre = c
					st = 3
				else # FATAL
					st = 100
				end
			when 20 # LLAVE/APELLIDO
				if c.match(/\s/) # llave
					llave << ant
					st = 12
				elsif c.match(/[a-z]/) # apellido
					nombre += ' '+ant+c
					st = 10
				end
			end
		end
		llave << 'a' if st == 16
		llave << ant if st == 20
		resultado << [nombre, llave]
		resultado.map {|n| n[0]}.join(' & ')
	end

	# PROCESA ARTICULO :BIB DE WEB OF SCIENCE (CARGA)
	def articulo_bib(bib_article)
		st = 0
		resultado = Hash.new
		llave = ''
		valor = ''
		palabra = ''

		# para el manejo de niveles adicionales
		origen = 0
		nivel = 0
#		bib_article.strip.split('').each do |c|
		bib_article.strip.each_char do |c|
			break if st == 100
			palabra += c
			case st
			when 0 # INICIO
				if c.match(/'s/) # elimina espacios (por seguridad)
				elsif c.match(/\{/) # inicio articulo
					st = 1
				else # FATAL
					st = 100
				end
			when 1 # INICIO ARTICULO
				if c.match(/\s/) # elimina espacios
				elsif c.match(/I/) # inicio ISI_ID
					st = 2
				else # FATAL
					st = 100
				end
			when 2 # INICIO ISI_ID
				if c.match(/[IS:0-9]/) # consume ISI_ID
					# no guarda el código porque aparece más adelante
				elsif c.match(/,/) # fin ISI_ID
					st = 3
				else # FATAL
					st = 100
				end
			when 3 # NOMBRE
				if c.match(/[\s\n]/) # elimina espacios y cambios de línea
				elsif c.match(/[a-zA-Z]/) # inicio campo
					llave += c
					st = 4
				else # FATAL
					st = 100
				end
			when 4 # LLAVE
				if c.match(/[a-zA-Z0-9\-\s]/) # inicio Inicial/Apellido? CAMBIAR LO DE ABAJO!
					llave += c
				elsif c.match(/=/) # =
					st = 5
				else # FATAL
					st = 100
				end
			when 5 # =
				if c.match(/[\s]/) # elimina espacios
				elsif c.match(/\{/) # 1er NIVEL
					st = 6
				else # FATAL
					st = 100
				end
			when 6 # . 1er NIVEL
				if c.match(/\{/) # 2do NIVEL
					st = 10
				elsif c.match(/\S/) # Inicial
					valor += c
					st = 7
				else # FATAL
					st = 100
				end
			when 7 # VALOR + control de niveles adicionales de {}
				if c.match(/[\n\\]/) # . Inicial
#					valor += ' '
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					origen = 7
					nivel = 1
					st = 50
				elsif c.match(/[^\}]/) # . Inicial
					valor += c
				elsif c.match(/\}/) # fin Inicial
					st = 8
				else # FATAL
					st = 100
				end
			when 8 # FIN 1er NIVEL
				if c.match(/[\s\n]/) # fin campo
				elsif c.match(/,/) # consume espacios
					resultado.store(llave.strip, valor.strip.split(' ').join(' '))
					llave = ''
					valor = ''
					st = 9
				else # FATAL
					st = 100
				end
			when 9 # FIN 1er NIVEL
				if c.match(/[\s\n]/) # consume espacios y cambios de linea
				elsif c.match(/\}/) # fin articulo
					st = 20
					break
				elsif c.match(/[a-zA-Z]/) # consume espacios
					llave += c
					st = 4
				else # FATAL
					st = 100
				end
			when 10 # VALOR
				if c.match(/[^\}]/) # completa apellido
					valor += c
					st = 11
				else # FATAL
					st = 100
				end
			when 11 # VALOR
				if c.match(/[\n\\]/) # 
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					origen = 11
					nivel = 1
					st = 50
				elsif c.match(/[^\}]/) # completa valor
					valor += c
				elsif c.match(/\}/) # primer cierre
					st = 12
				else # FATAL
					st = 100
				end
			when 12 # 1er CIERRE LLAVE
					#palabra += 'paso por 12 '+c
				if c.match(/\}/) # segundo cierre
					st = 8
				else # FATAL
					st = 100
				end
			when 50
				if c.match(/[\n\\]/) # 
				elsif c.match(/\{/) # . APERTURA nivel adicional
					valor += c
					nivel += 1
				elsif c.match(/[^\}]/) # completa valor
					valor += c
				elsif c.match(/\}/) # primer cierre
					nivel -=1
					st = origen if nivel == 0 # se pone antes!
				else # FATAL
					st = 100
				end
			end
		end
		resultado
	end
end
