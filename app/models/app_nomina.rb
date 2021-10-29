class AppNomina < ApplicationRecord

	TABLA_FIELDS = [
		['nombre', 'normal'],
		['email',  'normal']
	]

	validates :email, presence: true
	validates :email, uniqueness: true

end
