class FiloDefRol < ApplicationRecord

	has_many :filo_def_rol_interacciones
	has_many :filo_def_interacciones, through: :filo_def_rol_interacciones

end
