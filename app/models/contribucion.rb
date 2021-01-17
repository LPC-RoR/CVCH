class Contribucion < ApplicationRecord
	# LOS MODELOS DE CONTROLADORES CON FRAME TIENEN EL TITULO EN EL MODELO
	FRAME_TITULO = {
		'index'      => 'Contribuciones'
	}

	FRAME_ACTIONS_TYPE = {
		'index'     => 'tabla'
#		'parametros' => 'valor'
	}
end
