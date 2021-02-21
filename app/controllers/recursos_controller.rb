class RecursosController < ApplicationController
  before_action :authenticate_usuario!, only: :index
  before_action :inicia_session
  before_action :carga_temas_ayuda

  helper_method :sort_column, :sort_direction

	def index
		@coleccion = {}
		@coleccion['administradores'] = Administrador.all
		@coleccion['areas'] = Area.all
	end

	def home
		@coleccion = {}
		@coleccion['tema_ayudas'] = TemaAyuda.where(tipo: 'inicio').order(:orden)
		@coleccion['publicaciones'] = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10)
	end

  private
    # Use callbacks to share common setup or constraints between actions.

    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
