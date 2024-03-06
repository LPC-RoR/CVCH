                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        class FiloEspecie < ApplicationRecord

	TABLA_FIELDS = [
		's#filo_especie'
	]

	belongs_to :filo_elemento, optional: true

	# *****************      CAMBIO RELACIONES

	has_many :filo_esp_tipos
	has_many :filo_tipo_especies, through: :filo_esp_tipos

	has_many :filo_esp_cones
	has_many :filo_categoria_conservaciones, through: :filo_esp_cones

	# ****************************************

	has_one  :parent_relation, :foreign_key => "child_id", :class_name => "FiloEspEsp"
	has_many :child_relations, :foreign_key => "parent_id", :class_name => "FiloEspEsp"

	has_one  :parent, :through => :parent_relation
	has_many :children, :through => :child_relations, :source => :child

	has_many :car_filo_esps
	has_many :carpetas, through: :car_filo_esps

	has_many :filo_f_esp_regs
	has_many :regiones, through: :filo_f_esp_regs

	has_many :filo_esp_sinos
	has_many :filo_sinonimos, through: :filo_esp_sinos

	# despues se debe reeemplazar con has_one, solo se asocia directamente la especie propia
	has_many :especies

	has_many :filo_actualizaciones

	validates :filo_especie, presence: true

	before_save { self.filo_especie.downcase! }
	before_save :limpia_especie

	def imagenes
		AppImagen.where(owner_class: self.class.name, owner_id: self.id)
	end

	def limpia_especie
		self.filo_especie.gsub(/\t|\r|\n/, ' ').strip.downcase.split(' ').join(' ')
	end

	# **** TAXOMOMÍA

	def n_indent
		self.filo_elemento.present? ? (self.filo_elemento.n_indent + 2) : (self.parent.present? ? (self.parent.n_indent + 2) : 2 )
	end

	def genero
		self.parent.blank? ? self.filo_elemento : self.parent.filo_elemento
	end

	def fs_equivalentes
		e_ids = self.filo_esp_sinos.where(tipo: 'equivalente').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	def fs_sinonimos
		e_ids = self.filo_esp_sinos.where(tipo: 'sinónimo').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	def fs_excluidos
		e_ids = self.filo_esp_sinos.where(tipo: 'excluido').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	def fs_agregados
		e_ids = self.filo_esp_sinos.where(tipo: 'agregado').map {|fes| fes.filo_sinonimo.id}
		FiloSinonimo.where(id: e_ids)
	end

	def especie_sinonimo?
		e=Especie.find_by(especie: self.filo_especie)
		e.blank? ? false : e.filo_sinonimo.present?
	end

	def especie_padre
		self.especie_sinonimo? ? Especie.find_by(especie: self.filo_especie).filo_sinonimo.filo_especies.first : nil
	end

	def n_pubs_propias
		self.especies.empty? ? 0 : self.especies.map {|esp| esp.publicaciones.count}.sum
	end

	def n_pubs
		self.n_pubs_propias + self.filo_sinonimos.map {|sino| sino.n_pubs_propias}.sum
	end

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

	def multiple_sinonimia?
		self.sinonimia.present? or (self.filo_actualizaciones.map {|act| act.sinonimia unless act.sinonimia.blank?}.compact.length > 0)
	end

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

	def multiple_referencia
		base = self.referencia
		arreglo = self.filo_actualizaciones.empty? ? [] : self.filo_actualizaciones.order(updated_at: :desc).map {|act| act.referencia unless act.referencia.blank?}.compact
		base = base.blank? ? arreglo.first : base
		base.blank? ? '-' : base
	end

	def publicaciones
      etiquetas = self.especies
      sinonimos = self.filo_sinonimos

      pubs_ids = []
      etiquetas.each do |tag|
        pubs_ids = pubs_ids.union(tag.publicaciones.ids)
      end
      sinonimos.each do |sino|
        pubs_ids = pubs_ids.union(sino.especie.publicaciones.ids) unless sino.especie.blank?
      end
      Publicacion.where(id: pubs_ids)
	end

	def h_categorias
		hash_categorias = {}
		self.publicaciones.each do |pub|
			pub.categorias.each do |categoria|
				hash_categorias[categoria.categoria] = ( hash_categorias[categoria.categoria].blank? ? [pub.id] : hash_categorias[categoria.categoria].union([pub.id]) )
			end
		end
		hash_categorias
	end

	def huerfana?
		if self.parent.present?
			self.parent.filo_elemento.parent.blank?
		elsif self.filo_elemento.present?
			self.filo_elemento.parent.blank?
		end
	end

	# antiguos métodos: revisar
	def n_keys
		self.children.count + 1
	end

	def n_tags
		self.especies.count + self.children.map {|child| child.n_tags}.sum
	end

	def sinonimo?
		especie = Especie.find_by(especie: self.filo_especie)
		especie.blank? ? false : (self.especies.ids.exclude?(especie.id) and especie.filo_especie.present?)
	end

	def padre_sinonimo
		especie = Especie.find_by(especie: self.filo_especie)
		especie.blank? ? nil : especie.filo_especie
	end

	def conflictos
		FiloConflicto.where(id: FiloConfElem.where(filo_elem_class: self.class.name, filo_elem_id: self.id).map {|fe| fe.filo_conflicto.id unless fe.filo_conflicto.blank?}.compact)
	end
	# **************

	def n_especies
		self.children.count
	end

	def n_hijos
		self.children.count
	end

	def padre
		self.filo_elemento.blank? ? (self.especie_actual.blank? ? self.parent : self.especie_actual) : self.filo_elemento
	end

	def publicaciones_ids
		pub_ids = []
		self.especies.each do |esp|
			pub_ids = pub_ids.union(esp.publicaciones.ids)
		end
		pub_ids
	end

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

	def enlaces
		AppEnlace.where(owner_class: self.class.name, owner_id: self.id)
	end
end
