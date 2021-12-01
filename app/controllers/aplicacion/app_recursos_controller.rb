class Aplicacion::AppRecursosController < ApplicationController
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
    carga_sidebar('Administración', params[:t])
  end

  def procesos
    indices_proceso = Publicacion.all.map {|pub| pub.id if pub.areas.count == 1}.compact
    publicaciones = Publicacion.where(id: indices_proceso)
    publicaciones.each do |pub|
    end

    Especie.all.each do |esp|
      if esp.areas.empty?
        indices_pubs = esp.publicaciones.ids
        indices_proceso = indices_proceso & indices_pubs
        unless indices_proceso.empty?
          publicaciones = Publicacion.where(id: indices_proceso)
          pub_tally = publicaciones.map {|pub| pub.areas.first.id}.tally
          clave = nil
          valor = nil
          pub_tally.keys.each do |key|
            if clave.blank?
              clave = key
              valor = pub_tally[key]
            else
              if pub_tally[key] > valor
                clave = key
                valor = pub_tally[key]
              end
            end
          end
          unless clave.blank?
            area = Area.find(clave)
            esp.areas << area unless area.blank?
          end
        end
      end
    end


    carga_sidebar('Administración', params[:t])
    @coleccion = {}
    @coleccion['publicaciones'] = Publicacion.all.order(updated_at: :desc).page(params[:page])
    @paginate = true
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
