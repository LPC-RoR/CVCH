module CapitanRecursosHelper
	## ------------------------------------------------------- GENERAL

	## ------------------------------------------------------- LAYOUTS CONTROLLERS

	## ------------------------------------------------------- SCOPES & PARTIALS



	## ------------------------------------------------------- TABLA | BTNS

	def show_link_condition(objeto)
		true
	end

	## ------------------------------------------------------- SHOW

	def app_show_title(objeto)
		case objeto.class.name
		when 'Publicacion'
			objeto.title
		else
			objeto.send(objeto.class.name.tableize.singularize)
		end
	end

end
