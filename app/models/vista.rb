class Vista < ApplicationRecord
	TITULO = {
		'index'      => 'Colecciones',
		'escritorio' => 'Escritorio'
	}

	SELECTOR_NAME = {
		'index'      => 'Áreas',
		'escritorio' => 'Carpetas'
	}

	TABS = {
		'index' => ['Completa', 'Pendiente']
	}

	ACTIONS_TYPE = {
		'index'      => 'tabla',
		'escritorio' => 'tabla'
#		'parametros' => 'valor'
	}
end
