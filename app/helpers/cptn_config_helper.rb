module CptnConfigHelper
	def config
		{
			app: {
				nombre: 'CVCh',
				home: 'http://www.cvch.cl',
				logo_navbar: 'logo_navbar.gif'
			},
			layout: {
				menu_over: (not usuario_signed_in?),
				banner: true,
				menu: true,
			},
			margen: {
				over: publico? ? 1 : 0,
				menu: publico? ? 1 : 0,
				body: publico? ? 1 : 0
			},
			container: {
				over: publico?,
				menu: publico?,
				body: true
			},
			color: {
				app: 'info',
				navbar: 'info',
				navbar_bg: 'muted',
				help: 'dark',
				data: 'success',
				title_tema: 'info',
				detalle_tema: 'info'
			},	
			menu: {
				dd_enlaces: false,
				contacto: (not publico?),
				ayuda: (not publico?),
				recursos: false	# está en capitan/drop_down/_ddown_principal.html.erb REVISAR
			},
			image: {
				portada: {clase: img_class[:centrada], size: nil},
				tema: {clase: img_class[:centrada], size: 'half'},
				foot: {clase: img_class[:centrada], size: 'quarter'}
			},
			font_size: {
				title: 4,
				title_tema: 1,
				detalle_tema: 6
			},
			decimales: {
				'Pesos' => Rails.configuration.decimales_pesos,
				'UF' => Rails.configuration.decimales_uf
			},
			taxonomia: {
				elem_count: 10,
				esp_count: 10
			}
		}
	end

	def img_class 
		{
			centrada: 'mx-auto d-block'
		}
	end

end
