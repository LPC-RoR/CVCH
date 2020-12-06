class Publicacion < ApplicationRecord
	# NO SE USA EN CVCH AUN
	NOMBRES_BIB = ["Author", "Title", "Year", "Volume", "Month", "Abstract", "Publisher", "Address", "Affiliation", "DOI", "Article-Number", "ISSN", "EISSN", "Keywords", "Keywords-Plus", "Research-Areas", "Web-of-Science-Categories", "Author-Email", "Unique-ID", "DA"]

	# CVCH
	DOC_TYPES	 = ['article', 'book', 'tesis', 'memoria', 'chapter']

	EVALUACION = {
		'Objetivos' =>             ['delineados', 'confusos'],
		'Metodología' => ['fuerte', 'debil', 'controversial'],
		'Resultado' =>  ['significativo', 'no significativo'],
		'Conclusiones' =>    ['aceptadas', 'controversiales']
	}

	# ------------------- TABLA -----------------------
	TABS = Carpeta.all.map {|c| c.carpeta}
	# Configura DESPLIEGUE de la TABLA
	T_EXCEPTIONS = {
		tabs:    ['self'],
		paginas: ['*'],
		nuevo:   ['self', 'contribuciones']
	}

	# Campos qeu se despliegan en la tabla
	TABLA_FIELDS = [
		['title',         'show'], 
		['doc_type',    'normal'], 
		['year',        'normal']
	]

	T_NEW_EXCEPTIONS = {
		#'controller' => 'tipo_new'
		# '*' en todo controller_name
		'*' => 'mask',
	}
	# -------------------- FORM  -----------------------

 	FORM_FIELDS = [
		['doc_type',       'normal'], 
		['d_quote',         'entry'], 
		['m_quote',        'metodo'], 
		['d_author',        'entry'],
		['author',          'entry'], 
		['year',            'entry'], 
		['title',           'entry'],
		['book',            'entry'],
		['academic_degree', 'entry'],
		['d_journal',       'entry'],
		['volume',          'entry'],
		['pages',           'entry'],
		['d_doi',           'entry'],
		['doi',             'entry'],
		['abstract',    'text_area'],

		['estado',         'hidden']
	]

	FORM_CONDITIONAL_FIELDS = ['d_quote', 'm_quote', 'doi', 'd_author', 'd_doi', 'abstract', 'academic_degree', 'volume', 'book', 'pages', 'd_journal', 'title', 'year', 'author']

	# -------------------- SHOW -------------------------
	SHOW_FIELDS = [
		['d_quote',         'normal'], 
		['m_quote',         'metodo'], 
		['author',          'normal'], 
		['year',            'normal'], 
		['title',           'normal'],
		['book',            'normal'],
		['academic_degree', 'normal'],
		['d_journal',       'normal'],
		['volume',          'normal'],
		['pages',           'normal'],
		['doi',             'normal']
	]

	S_E = [:clasifica, :detalle, :tabla]
	# --------------------- DESPLIEGUE -------------------------
	# tablas child que NO deben ser deplegadas
	HIDDEN_CHILDS = ['autores', 'investigadores', 'procesos', 'cargas', 'clasificaciones', 'carpetas', 'evaluaciones', 'asignaciones', 'areas']

	# LINKS !!
	S_BT_OBJECTS = ['revista']
	S_HMT_COLLECTIONS = ['cargas', 'investigadores']

	belongs_to :registro, optional: true
	belongs_to :revista, optional: true
	belongs_to :equipo, optional: true
	belongs_to :investigador, optional: true
	belongs_to :area, optional: true

	has_many :evaluaciones

	has_many :autores
	has_many :investigadores, through: :autores

	has_many :procesos
	has_many :cargas, through: :procesos

	has_many :clasificaciones
	has_many :carpetas, through: :clasificaciones

	has_many :asignaciones, foreign_key: 'paper_id', class_name: 'Clasificacion'
	has_many :areas, through: :asignaciones

	has_many :rutas
	has_many :instancias, through: :rutas

	def show_title
		"| #{self.title}"
	end

	def show_links
		[
			['Editar', [:edit, self], true],
			['Eliminar', "/publicaciones/estado?publicacion_id=#{self.id}&estado=eliminado", ['ingreso', 'duplicado', 'carga'].include?(self.estado)],
			['Contribuir', "/publicaciones/estado?publicacion_id=#{self.id}&estado=contribucion", ['ingreso'].include?(self.estado)],
			['Publicar', "/publicaciones/estado?publicacion_id=#{self.id}&estado=publicada", (['contribucion', 'carga'].include?(self.estado) and not (self.doc_type.blank? or self.areas.empty?))],
			['Carga', "/publicaciones/estado?publicacion_id=#{self.id}&estado=carga", ['duplicado'].include?(self.estado)],
			['Corregir', "/publicaciones/estado?publicacion_id=#{self.id}&estado=correccion", self.estado == 'publicada']
		]
		
	end

	def btns_control
		['ingreso'].include?(self.origen) and ['ingreso'].include?(self.estado)
	end

	def procesa_autor(author, index)
		partes = author.split(' ')
		if index == 0
			if partes.length == 2
				partes_0 = partes[0] == partes[0].upcase ? partes[0] : partes[0][0].upcase
				"#{partes[1].upcase} #{partes_0}"
			elsif partes.length == 3
				"#{partes[2].upcase} #{partes[0][0].upcase}#{partes[1].delete_suffix('.')}"
			elsif partes.length > 3
				primero = partes[0]
				del_medio = partes[2..-2]
				ultima = partes.last
				"#{del_medio.map {|p| p[0]}.join('')}#{ultima.upcase} #{partes[0][0].upcase}#{partes[1].delete_suffix('.')}"
			end
		else
			if partes.length == 2
				partes_0 = partes[0] == partes[0].upcase ? partes[0] : partes[0][0].upcase
				"#{partes_0.upcase} #{partes[1].upcase}"
			elsif partes.length == 3
				"#{partes[0][0].upcase}#{partes[1].delete_suffix('.')} #{partes[2].upcase}"
			elsif partes.length > 3
				primero = partes[0]
				del_medio = partes[2..-2]
				ultima = partes.last
				"#{partes[0][0].upcase}#{partes[1].delete_suffix('.')} #{del_medio.map {|p| p[0]}.join('')}#{ultima.upcase}"
			end
		end
	end
	def procesa_autores(author)
		ultimo = author.split(' &').last.strip
		primeros = author.split(' & ')[0].split(', ')
		primeros_ok = primeros.each_with_index.map {|aut, i| procesa_autor(aut, i)}
		ultimo_ok = procesa_autor(ultimo, 666)
		primeros_ok.join(', ')+' & '+ultimo_ok
	end

	def m_quote
		autores = self.origen == 'ingreso' ? procesa_autores(self.author) : self.author
		case self.doc_type
		when 'article'
			"#{autores} (#{self.year}) #{self.title}. #{self.d_journal} #{self.volume}: #{self.pages} #{self.doi}".strip+'.'
		when 'book'
			"#{autores} (#{self.year}) #{self.title}. #{self.d_journal} #{self.pages} #{self.doi}".strip+'.'
		when 'tesis'
			"#{autores} (#{self.year}) #{self.title}. Tesis #{self.d_journal} #{self.pages} #{self.doi}".strip+'.'
		when 'memoria'
			"#{autores} (#{self.year}) #{self.title}. Memoria para optar al Título Profesional de #{self.academic_degree}, #{self.d_journal} #{self.pages} #{self.doi}".strip+'.'
		end
	end

	def c_d_quote
		# Sólo duplicados de origen carga, las publicaciones de 'ingreso' no tienen cita
		self.estado == 'carga' or (self.origen == 'carga' and self.estado == 'duplicado')
	end
	def c_m_quote
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_doi
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_d_author
		self.estado == 'ingreso'
	end
	def c_d_doi
		self.estado == 'ingreso'
	end
	def c_abstract
		self.estado == 'ingreso'
	end
	def c_academic_degree
		self.doc_type == 'memoria' and ['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_volume
		self.doc_type == 'article' and ['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_book
		self.doc_type == 'chapter' and ['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_pages
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_d_journal
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_title
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_year
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
	def c_author
		['carga', 'ingreso', 'duplicado'].include?(self.estado)
	end
end
