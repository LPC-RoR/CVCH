class Revision < ApplicationRecord
	TITULO = 'Revision de Citas'

	TABS = {
		'index' => ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera']
	}

	# NO USADA EN ESTA OCASION
#	TABS = {
#		'index' => ['ingreso', 'carga']
#	}

	# Cada acción SOLO despliega un tipo 'tabla' o 'valor', para simplifaicar
	# Hasta el mínuto SOLO se usa 'manual'
	ACTIONS_TYPE = {
		'index'     => 'tabla'
#		'parametros' => 'valor'
	}
end
