class Vista < ApplicationRecord
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	FRAME_TITULO = {
		'index'      => 'Colecciones',
		'escritorio' => 'Escritorio'
	}

	FRAME_TABS = {
		'index' => ['Completa', 'Pendiente']
	}

	FRAME_SELECTOR = {
		'index'      => 'Áreas',
		'escritorio' => 'Carpetas'
	}

	FRAME_ACTIONS_TYPE = {
		'index'      => 'tabla',
		'escritorio' => 'tabla'
#		'parametros' => 'valor'
	}
end
