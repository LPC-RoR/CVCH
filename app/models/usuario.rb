class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	TABLA_FIELDS = [
		'email',
		'd_tipo_usuario',
		'd_fecha_incorporacion'
	]

	scope :ordered, -> { order(:created_at) }

	def d_tipo_usuario
		(AppAdministrador.find_by(email: self.email).blank? ? 'usuario' : 'administrador')
	end

	def d_fecha_incorporacion
		self.created_at
	end
end
