class Aplicacion::AppRecursosController < ApplicationController
  before_action :authenticate_usuario!, only: [:administracion, :procesos]
  before_action :inicia_sesion, only: [:administracion, :procesos, :home]

  include Sidebar

  helper_method :sort_column, :sort_direction

  def index
  end

  def home
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    init_tabla( 'publicaciones', Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction), false )
    add_tabla( 'tema_ayudas', TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden), false )
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
      unless filo_especie.filo_tipo_especie_id.blank?
        filo_tipo_especie = FiloTipoEspecie.find(filo_especie.filo_tipo_especie_id)
        filo_especie.filo_tipo_especies << filo_tipo_especie unless filo_especie.filo_tipo_especies.ids.include?(filo_tipo_especie)
      end

      unless filo_especie.filo_categoria_conservacion_id.blank?
        filo_categoria_conservacion = FiloCategoriaConservacion.find(filo_especie.filo_categoria_conservacion_id)
        filo_especie.filo_categoria_conservaciones << filo_categoria_conservacion unless filo_especie.filo_categoria_conservaciones.ids.include?(filo_categoria_conservacion.id)
      end

      if filo_especie.rara == true
        categoria = FiloCategoriaConservacion.find_by(codigo: 'R')
        filo_especie.filo_categoria_conservaciones << categoria unless filo_especie.filo_categoria_conservaciones.ids.include?(categoria.id)
      end

      link_mma = filo_especie.enlaces.find_by(descripcion: 'bootstrap')
      unless link_mma.blank?
        filo_especie.link_fuente = link_mma.enlace
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
