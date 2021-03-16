class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


	TABLA_FIELDS = [
		['email',         'normal'],
		['d_tipo_usuario',  'normal']
	]

	def d_tipo_usuario
		(Administrador.find_by(email: self.email).blank? ? 'usuario' : 'administrador')
	end
end
