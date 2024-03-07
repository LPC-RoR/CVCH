module Tablas
	extend ActiveSupport::Concern

	def menu_tablas
		{
			admin: [
				#['Título', 'partial', indent, despliegue]
				['General', nil, 1, true],
				['Regiones', 'regiones', 2, true],
				['Publicaciones', nil, 1, true],
				['Áreas & Categorías', 'areas_categorias', 2, true],
				['Taxonomía', nil, 1, true],
				['Tipos', 'tipos', 2, true],
				['Categorías & Fuentes', 'categorias_fuentes', 2, true],
				['Interacciones', 'interacciones', 2, true],
			]
		}
	end

	def tb_index(sym, clave)
		menu_tablas[sym].map {|e| e[1]}.index(clave)
	end

	def tb_item(sym, indice)
		menu_tablas[sym][indice][0]
	end

	def first_tabla_index(sym)
		tb_index(sym, menu_tablas[sym].map {|e| e[1]}.compact.first)
	end

end