class RecursosController < ApplicationController
  before_action :authenticate_usuario!, only: :index
  before_action :inicia_session
  before_action :carga_temas_ayuda

	def index
		@coleccion = {}
		@coleccion['administradores'] = Administrador.all
		@coleccion['areas'] = Area.all
	end

	def home
		@coleccion = TemaAyuda.where(tipo: 'inicio').order(:orden)
	end
end
