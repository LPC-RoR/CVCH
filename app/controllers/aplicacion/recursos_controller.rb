class Aplicacion::RecursosController < ApplicationController
  before_action :authenticate_usuario!, only: :index
  before_action :inicia_sesion

  include Sidebar

  helper_method :sort_column, :sort_direction

	def index
		@coleccion = {}
		@coleccion['administradores'] = Administrador.all
		@coleccion['areas'] = Area.all

    @coleccion['mejoras'] = Mejora.all if session[:es_administrador]
    @coleccion['usuarios'] = Usuario.all.order(created_at: :asc)
	end

	def home
		@coleccion = {}
    @coleccion['tema_ayudas'] = TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden)
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
		@coleccion['publicaciones'] = Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction)
	end

  def ayuda
    carga_sidebar('Ayuda', params[:t])
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
    # Trae sidebar desde concern 'sidebar.rb'

    carga_sidebar('Administración', params[:t])
  
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
