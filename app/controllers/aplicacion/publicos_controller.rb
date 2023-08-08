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

      if @objeto.parent.blank?
        hermanos_ids = FiloElemento.all.map {|elemento| elemento.id if elemento.parent.blank? and elemento.id != @objeto.id}.compact
      else
        hermanos_ids = @objeto.parent.children.map {|elem| elem.id unless elem.id == @objeto.id}.compact
      end
      @hermanos = FiloElemento.where(id: hermanos_ids).order(:filo_elemento)

      # limpia errores en children
#      if @objeto.child_relations.count != @objeto.children.count
#        @objeto.child_relations.each do |chr|
#          @objeto.child_relations.delete(chr) if chr.child.blank?
#        end
#      end

    end      
  end

  def especies
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])
      init_tabla('filo_especies', @objeto.children.order(:filo_especie), false)

      regiones_para_asignar_ids = Region.all.map {|region| region.id unless @objeto.regiones.ids.include?(region.id)}.compact
      @regiones_para_asignar = Region.where(id: regiones_para_asignar_ids).order(:orden)

      # recuperación de especies perdidas
      if @objeto.parent.blank? and @objeto.filo_elemento.blank?
        elemento = @objeto.filo_especie.split(' ')[0].strip
        sustituto = FiloElemento.find_by(filo_elemento: elemento)
        @objeto.filo_categoria_conservacion_id = FiloCategoriaConservacion.first.id if @objeto.filo_categoria_conservacion.blank?
        @objeto.filo_tipo_especie_id = FiloTipoEspecie.first.id if @objeto.filo_tipo_especie.blank?
        sustituto.filo_especies << @objeto
      end

      @padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
      @abuelo = @objeto.parent.present? ? @padre.filo_elemento : @padre.parent

      # En este caso puede haber HERMANOS ELEMENTOS/ESPECIES
      @hermanos_elementos = @objeto.parent.present? ? nil : @padre.children
      @hermanos_especies = @objeto.parent.present? ? nil : @padre.filo_especies
    end
  end

  def publicaciones
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])
      @etiquetas = @objeto.especies
      pubs_ids = []
      @etiquetas.each do |tag|
        pubs_ids = pubs_ids.union(tag.publicaciones.ids)
        init_tabla("publicaciones", Publicacion.where(id: pubs_ids).order(:title), true)
      end
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
