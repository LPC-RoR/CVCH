class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include Sidebar

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    @coleccion = {}
    @coleccion['tema_ayudas'] = TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden)
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    @coleccion['publicaciones'] = Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction)
  end

  def ayuda
    carga_sidebar('Ayuda', params[:id])
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
    carga_sidebar('Administración', params[:id])
  end

  def procesos
    carga_sidebar('Administración', params[:id])
    @enrique_perfil = AppPerfil.find_by(email: 'esilva@bio.puc.cl')
    @enrique_admin = AppAdministrador.find_by(email: 'esilva@bio.puc.cl')
#    redirect_to root_path
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
