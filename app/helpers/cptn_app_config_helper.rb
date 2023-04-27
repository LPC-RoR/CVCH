module CptnAppConfigHelper
	def config
		{
			app: {
				nombre: 'CVCh',
				home: 'http://www.cvch.cl',
				logo_navbar: 'logo_navbar.gif'
			},
			color: {
				app: 'info',
				navbar: 'info',
				help: 'dark',
				data: 'success',
				title_tema: 'info',
				detalle_tema: 'info'
			},	
			menu: {
				dd_enlaces: false,
				contacto: true,
				ayuda: true,
				recursos: false	# está en capitan/drop_down/_ddown_principal.html.erb REVISAR
			},
			image: {
				portada: {clase: ctes[:image][:centrada], size: nil},
				tema: {clase: ctes[:image][:centrada], size: 'half'},
				foot: {clase: ctes[:image][:centrada], size: 'half'}
			},
			font_size: {
				title: 4,
				title_tema: 1,
				detalle_tema: 6
			}
		}
	end
end
