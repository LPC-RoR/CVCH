                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        class FiloEspecie < ApplicationRecord

	TABLA_FIELDS = [
		's#filo_especie'
	]

	belongs_to :filo_elemento, optional: true
#	belongs_to :filo_categoria_conservacion
#	belongs_to :filo_tipo_especie

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

	has_many :especies

	# **** TAXOMOMÍA
	def n_keys
		self.children.count + 1
	end

	def n_tags
		self.especies.count + self.children.map {|child| child.n_tags}.sum
	end

	def n_pubs
		self.especies.map {|esp| esp.publicaciones.count}.sum + self.children.map {|child| child.n_pubs}.sum
	end

	def sinonimo?
		especie = Especie.find_by(especie: self.filo_especie)
		especie.blank? ? false : (self.especies.ids.exclude?(especie.id) and especie.filo_especie.present?)
	end

	def padre_sinonimo
		especie = Especie.find_by(especie: self.filo_especie)
		especie.blank? ? nil : especie.filo_especie
	end

	def mma_link?
		enlaces = self.enlaces
		enlaces.empty? ? false : enlaces.find_by(descripcion: 'mma').present?
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
		unless self.sinonimia.blank?
			sin_arr = self.sinonimia.split(';')
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
		unless self.sinonimia.blank?
			sin_arr = self.sinonimia.split(';')
			result = []
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
			result
		end
	end

	def enlaces
		AppEnlace.where(owner_class: self.class.name, owner_id: self.id)
	end
end
