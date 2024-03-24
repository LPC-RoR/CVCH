class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include ProcesaEstructura

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    # DEPRECATED
  end

  def ayuda
#    carga_tutorial(@sb_elementos, @t)
  end

  def administracion
  end

  def procesos
#    FiloEspecie.all.each do |filo_especie|
#      genero = filo_especie.filo_especie.split(' ')[0]
#      filo_elemento = FiloElemento.find_by(filo_elemento: genero)
#      unless filo_elemento.blank?
#        unless filo_elemento.filo_especies.map {|fe| fe.filo_especie}.include?(filo_especie.filo_especie)
#          filo_elemento.filo_especies << filo_especie
#        end
#      end
#    end

    FiloEspecie.all.each do |filo_especie|
      padre = filo_especie.parent
      unless padre.blank?
        filo_especie.filo_elemento_id = nil
        filo_especie.save
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
  