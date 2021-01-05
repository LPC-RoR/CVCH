class Revision < ApplicationRecord
	TITULO = {
		'index'      => 'Revisión de Citas'
	}

	TABS = {
		'index' => ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera']
	}


	SELECTOR_NAME = {
		'index'      => 'Áreas'
	}

	# Cada acción SOLO despliega un tipo 'tabla' o 'valor', para simplifaicar
	# Hasta el mínuto SOLO se usa 'manual'
	ACTIONS_TYPE = {
		'index'     => 'tabla'
#		'parametros' => 'valor'
	}

end
