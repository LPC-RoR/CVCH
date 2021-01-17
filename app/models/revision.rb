class Revision < ApplicationRecord
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	FRAME_TITULO = {
		'index'      => 'Revisión de Citas'
	}

	FRAME_TABS = {
		'index' => ['Cargas', 'Contribuciones', 'Formatos', 'Duplicados', 'Papelera']
	}


	FRAME_SELECTOR = {
		'index'      => 'Áreas'
	}

	# Cada acción SOLO despliega un tipo 'tabla' o 'valor', para simplifaicar
	# Hasta el mínuto SOLO se usa 'manual'
	FRAME_ACTIONS_TYPE = {
		'index'     => 'tabla'
#		'parametros' => 'valor'
	}

end
