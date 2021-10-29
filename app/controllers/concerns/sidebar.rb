module Sidebar
	extend ActiveSupport::Concern

	# SIDEBAR

	def get_lista(nombre)
		lista = SbLista.find_by(lista: nombre)
	end

	def get_elementos(lista)
		lista.blank? ? nil : lista.sb_elementos.order(:orden)
	end

	def first_elemento(elementos)
		unless elementos.blank?
			lista_item = elementos.where(tipo: 'item')
			(lista_item.blank? ? nil : lista_item.order(:orden).first)
		else
			nil
		end
	end

	def get_t(elementos, param_t)
		if param_t.blank?
			first_elemento(elementos).blank? ? nil : first_elemento(elementos).elemento
		else
			param_t
		end
	end

	def get_controller(elementos, param_t)
		if param_t.blank?
			first_elemento(elementos).blank? ? nil : first_elemento(elementos).controlador
		else
			elementos.find_by(elemento: param_t).controlador
		end
	end

	def get_display(elementos, param_t)
		if param_t.blank?
			first_elemento(elementos).blank? ? nil : first_elemento(elementos).despliegue
		else
			elementos.find_by(elemento: param_t).despliegue
		end
	end

	def carga_sidebar(nombre, param_t)
	    @sb_name = nombre

	    lista = get_lista(nombre)
	    @tipo_lista = (lista.lista == 'Ayuda' ? 'ayuda' : 'item')

    	@sb_link = (lista.blank? ? nil : lista.link)
	    @sb_elementos = get_elementos(lista)

	    unless ['new', 'edit', 'create', 'show'].include?(action_name)
	    	@t = get_t(@sb_elementos, param_t)
	    	@controlador = get_controller(@sb_elementos, @t)
	    	@despliegue = get_display(@sb_elementos, @t)

		    if @despliegue == 'show'
	    		@objeto = @controlador.classify.constantize.first
		    elsif @despliegue == 'ayuda'
			    @objeto = HlpTutorial.find_by(clave: @controlador)
			    @coleccion = {}
			    @coleccion['hlp_pasos'] = @objeto.hlp_pasos.order(:orden) unless @objeto.blank?
		    elsif ['list', 'ulist'].include?(@despliegue)
		    	@coleccion = {}

				if @controlador.classify.constantize.all.count < 26 or @despliegue == 'ulist'
					@coleccion[@controlador] = @controlador.classify.constantize.all
					@paginate = false
				else
					@coleccion[@controlador] = @controlador.classify.constantize.all.page(params[:page])
					@paginate = true
				end

		    end
		end
	end

	def nombre_sidebar(controller)
		'Administración'
	end
end
