class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include Sidebar
  include ProcesaEstructura

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    set_tabla( 'publicaciones', Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction), false )
    set_tabla( 'tema_ayudas', TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden), false )
  end

  def ayuda
    carga_sidebar('Ayuda', params[:t])
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
    carga_sidebar('Administración', params[:id])
  end

  def procesos
    FiloEspecie.all.each do |filo_especie|
      genero = filo_especie.filo_especie.split(' ')[0]
      filo_elemento = FiloElemento.find_by(filo_elemento: genero)
      unless filo_elemento.blank?
        unless filo_elemento.filo_especies.map {|fe| fe.filo_especie}.include?(filo_especie.filo_especie)
          filo_elemento.filo_especies << filo_especie
        end
      end
    end

    redirect_to root_path
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
  