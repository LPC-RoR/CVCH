class FiloDefInteraccion < ApplicationRecord

	has_many :filo_def_rol_interacciones
	has_many :filo_def_roles, through: :filo_def_rol_interacciones

	has_many :filo_interacciones

end
