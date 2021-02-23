class Administrador < ApplicationRecord
	TABLA_FIELDS = [
		['administrador', 'normal'], 
		['email',         'normal']
	]

 	FORM_FIELDS = [
		['administrador',  'entry'],
		['email',          'entry']
	]

	has_one :perfil

	validates :administrador, :email, presence: true
	validates :administrador, :email, uniqueness: true

end
