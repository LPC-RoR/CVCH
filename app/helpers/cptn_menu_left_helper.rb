module CptnMenuLeftHelper
	## ------------------------------------------------------- MENU

	def menu_left
		{
			pubs: [
				
			],
			admin: [
				{
					titulo: 'Tablas', 
					condicion: admin? 
				},
				{
					titulo: 'Administracion', 
					condicion: admin?, 
					items: [
						'AppNomina',
						'StModelo',
						'BlgArticulo',
						'HImagen'
					]
				},
				{
					titulo: 'App', 
					condicion: dog?, 
					items: [
						'AppVersion'
					]
				}
			]
		}
	end

	def admin_controllers
		['app_nominas', 'usuarios', 'st_modelos', 'st_estados', 'control_documentos', 'blg_articulos', 'app_versiones', 'h_imagenes', 'filo_def_interacciones', 'filo_def_roles', 'eco_formaciones', 'eco_pisos', 'eco_lugares', 'h_imagenes']
	end

	def tablas_controllers
		['tablas', 'regiones', 'areas', 'categorias', 'filo_ordenes', 'filo_tipo_especies', 'filo_categoria_conservaciones', 'filo_fuentes']
	end

	def left_menu_actions?
		controller_name == 'app_recursos' and action_name == 'administracion' and usuario_signed_in?
	end

	def left_menu_controllers?
		admin_controllers.include?(controller_name) or tablas_controllers.include?(controller_name)
	end

	def left_menu_sym
		( left_menu_actions? or left_menu_controllers?) ? :admin : nil
	end

	# Determina la RUTA DESTINO usándo como parámetro el modelo del ítem
	def model_link(modelo)
		if modelo == 'Usuario'
			"/app_recursos/usuarios"
		else
			"/#{modelo.tableize}"
		end
	end

	# Determina el MODELO del ítem  dado el controlador desplegado
	def link_model(controller)
		if controller == 'app_recursos'
			"Usuario"
		else
			"#{controller.classify}"
		end
	end

	# Determina el ÍTEM dado el mdoelo del item
	def modelo_item(modelo)
		if modelo == 'AppNomina'
			'Nómina'
		elsif modelo == 'StModelo'
			'Personalización'
		elsif modelo == 'HImagen'
			'Ímagenes'
		else
			m_to_name(modelo).tableize.capitalize
		end
	end

end