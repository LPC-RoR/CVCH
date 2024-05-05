class FiloEspecie < ApplicationRecord

	belongs_to :filo_elemento, optional: true

	# *****************      CAMBIO RELACIONES

	has_many :filo_esp_tipos
	has_many :filo_tipo_especies, through: :filo_esp_tipos

	has_many :filo_esp_cones
	has_many :filo_categoria_conservaciones, through: :filo_esp_cones

	# **************************************** PARENT - CHILDREN

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEspEsp"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEspEsp"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	# **************************************** MANY TOO MANY

	has_many :car_filo_esps
	has_many :carpetas, through: :car_filo_esps

	has_many :filo_f_esp_regs
	has_many :regiones, through: :filo_f_esp_regs

	has_many :filo_esp_sinos
	has_many :filo_sinonimos, through: :filo_esp_sinos

	# **************************************** 1 TO MANY

	# despues se debe reeemplazar con has_one, solo se asocia directamente la especie propia
	has_one :especie

	has_many :filo_actualizaciones

	has_many :filo_roles

	# **************************************** ACTIONS

	validates :filo_especie, presence: true

	before_save { self.filo_especie.downcase! }
	before_save :limpia_especie

	# Se usa para limpiar nombres que se ponen unsando copy paste
	def limpia_especie
		self.filo_especie.gsub(/\t|\r|\n/, ' ').strip.downcase.split(' ').join(' ')
	end

	# **************************************** OWNER RELATIONS

	def imagenes
		AppImagen.where(owner_class: self.class.name, owner_id: self.id)
	end

	# **************************************** TAXOMOMÍA

	# Determina laa indentación de la especie en el árbol desplegado
	def n_indent
		self.filo_elemento.present? ? (self.filo_elemento.n_indent + 2) : (self.parent.present? ? (self.parent.n_indent + 4) : 2 )
	end

	# Entrega una lista de padres
	def padres
		padre = self.parent.present? ? self.parent : self.filo_elemento
		padre.present? ? [padre].union(padre.padres) : []
	end

	# Obtiene el Genero de la Especie
	def genero
		self.parent.blank? ? self.filo_elemento : self.parent.filo_elemento
	end

	# FiloSinonimo del tipo 'equivalente'
	def fs_equivalentes
		e_ids = self.filo_esp_sinos.where(tipo: 'equivalente').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	# FiloSinonimo del tipo 'sinónimo'
	def fs_sinonimos
		e_ids = self.filo_esp_sinos.where(tipo: 'sinónimo').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	# FiloSinonimo del tipo 'excluido'
	def fs_excluidos
		e_ids = self.filo_esp_sinos.where(tipo: 'excluido').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	# FiloSinonimo del tipo 'agregado'
	def fs_agregados
		e_ids = self.filo_esp_sinos.where(tipo: 'agregado').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	# Determina si la especie es sinónimo
	# REVISAR, debiera cambiar al cambiar has_many por has_one
	def especie_sinonimo?
		e=Especie.find_by(especie: self.filo_especie)
		e.blank? ? false : e.filo_sinonimo.present?
	end

	# Se usa para especies que son sinónimos
	# la especie padre es la que tiene el nombre actual
	def especie_padre
		self.especie_sinonimo? ? Especie.find_by(especie: self.filo_especie).filo_sinonimo.filo_especies.first : nil
	end

	# Publicaciones asociaadas a FiloEspecie ( se relacionan a través de Especie )
	# funciona con has_many :especies, debe cambiar a has_one
	def n_pubs_propias
		self.especie.present? ? self.especie.publicaciones.count : 0
	end

	# TOTAL de publicaciones, contando las relacionadas a través de la sinonimia
	def n_pubs
		self.n_pubs_propias + self.filo_sinonimos.map {|sino| sino.n_pubs_propias}.sum
	end

	# Construye el Nombre comùn que une los del filo_especie con los aportados por las actualizaciones
	def multiple_nombre_comun
		base = self.nombre_comun.blank? ? [] : self.nombre_comun.downcase.split(';').collect(&:strip)
		arreglo = self.filo_actualizaciones.empty? ? [] : self.filo_actualizaciones.map {|act| act.nombre_comun unless act.nombre_comun.blank?}.compact
		unless arreglo.empty?
			arreglo.each do |nc|
				base = base.union( nc.downcase.split(';').collect(&:strip) )
			end
		end
		base.uniq.sort.join('; ')
	end

	# Si tiene mùltiple sinonimia
	def multiple_sinonimia?
		self.sinonimia.present? or (self.filo_actualizaciones.map {|act| act.sinonimia unless act.sinonimia.blank?}.compact.length > 0)
	end

	# Construye la Sinonimia que une la del filo_especie con los aportados por las actualizaciones
	def multiple_sinonimia
		base = self.sinonimia.blank? ? [] : self.sinonimia.downcase.split(';').collect(&:strip)
		arreglo = self.filo_actualizaciones.empty? ? [] : self.filo_actualizaciones.map {|act| act.sinonimia unless act.sinonimia.blank?}.compact
		unless arreglo.empty?
			arreglo.each do |sino|
				base = base.union( sino.downcase.split(';').collect(&:strip) )
			end
		end
		base.uniq.sort.join('; ')
	end

	# Obtiene la referencia más actualizada entre filo_especie y las actualizaciones
	def multiple_referencia
		base = self.referencia
		arreglo = self.filo_actualizaciones.empty? ? [] : self.filo_actualizaciones.order(updated_at: :desc).map {|act| act.referencia unless act.referencia.blank?}.compact
		base.blank? ? arreglo.first : base
	end

	# Todas las publicaciones asociadas a la filo_especie
	def publicaciones
      etiqueta = self.especie
      sinonimos = self.filo_sinonimos

      pubs_ids = etiqueta.publicaciones.ids
      sinonimos.each do |sino|
        pubs_ids = pubs_ids.union(sino.especie.publicaciones.ids) unless sino.especie.blank?
      end
      Publicacion.where(id: pubs_ids)
	end

	# Construye un Hash con las categorías en las que está presente la filo_especie
	def h_categorias
		hash_categorias = {}
		self.publicaciones.each do |pub|
			pub.categorias.each do |categoria|
				hash_categorias[categoria.categoria] = ( hash_categorias[categoria.categoria].blank? ? [pub.id] : hash_categorias[categoria.categoria].union([pub.id]) )
			end
		end
		hash_categorias
	end

	# Se usan en filo_sinonimo.rb
	def huerfana?
		# Si es subespecie
		if self.parent.present?
			# Si el género tiene un padre
			self.parent.filo_elemento.parent.blank?
		# es especie
		elsif self.filo_elemento.present?
			# si el genero tiene un padre
			self.filo_elemento.parent.blank?
		end
	end

	# Los próximos siguientes son iguales. VERIFICAR
	def n_especies
		self.children.count
	end

	def n_hijos
		self.children.count
	end

	# hay muchos 'padre' en distintos modelos VERIFICAR
	def padre
		self.filo_elemento.blank? ? (self.especie_actual.blank? ? self.parent : self.especie_actual) : self.filo_elemento
	end

	# Genera un Hash de la sinonimia actualizada
	def sinonimia_list
		unless self.multiple_sinonimia.blank?
			sin_arr = self.multiple_sinonimia.split(';')
			sin_has = {}
			sin_arr.each do |sin|
				m = sin.match(/[^\d](\d{4})[^\d]*/)
				unless m.blank?
					unless m[1].blank?
						sin_has[sin] = m[1].strip
					else
						sin_has[sin] = "Error en match : #{m[1]}"
					end
				else
					sin_has[sin] = "Error en match"
				end
			end
			sin_has.sort_by { |sinonimo, annio| annio }.reverse
		end
	end

	# Genera un Array de la sinonimia actualizada
	def sinonimos
		result = []
		if self.multiple_sinonimia?
			sin_arr = self.multiple_sinonimia.split(';')
			sin_arr.each do |sin|
				m = sin.match(/[^\.]*(?=\.)/)
				unless m.blank?
					unless m[0].blank?
						result << m[0].strip.downcase
					else
						result << sin.downcase
					end
				else
					result << sin.downcase
				end
			end
		end
		result
	end

	# VERIFICAR enlaces del filo_especie
	def enlaces
		AppEnlace.where(owner_class: self.class.name, owner_id: self.id)
	end
end
