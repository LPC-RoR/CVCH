class Aplicacion::PublicosController < ApplicationController
  before_action :set_publico, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction
  
  def home
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    init_tabla( 'publicaciones', Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction), false )
    add_tabla( 'tema_ayudas', TemaAyuda.where(tipo: 'inicio').where(activo: true).order(:orden), false )
  end

  def taxonomia
    if params[:indice].blank?
      base_ids = FiloElemento.all.map {|fe| fe.id unless fe.parent.present?}.compact
      init_tabla('base-filo_elementos', FiloElemento.where(id: base_ids).order(:filo_elemento), false)
      @padres_ids = nil
    else
      @objeto = FiloElemento.find(params[:indice])
      init_tabla('base-filo_elementos', @objeto.children.order(:filo_elemento), false)
      add_tabla('filo_especies', @objeto.filo_especies.order(:filo_especie), false)
      @padres_ids = @objeto.padres_ids.reverse()
    end      
  end

  def especies
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])
      init_tabla('filo_especies', @objeto.children.order(:filo_especie), false)

      regiones_para_asignar_ids = Region.all.map {|region| region.id unless @objeto.regiones.ids.include?(region.id)}.compact
      @regiones_para_asignar = Region.where(id: regiones_para_asignar_ids).order(:orden)
#      @padres_ids = @objeto.padres_ids.reverse()
    end
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
