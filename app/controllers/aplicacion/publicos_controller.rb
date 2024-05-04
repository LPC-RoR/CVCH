class Aplicacion::PublicosController < ApplicationController
  before_action :set_publico, only: [:show, :edit, :update, :destroy]
  before_action :inicia_sesion, only: [:home]

  helper_method :sort_column, :sort_direction
  
  def home
    ultimos_ids = Publicacion.where(estado: 'publicada').order(created_at: :asc).last(10).map {|pub| pub.id}
    set_tabla( 'publicaciones', Publicacion.where(id: ultimos_ids).order(sort_column + " " + sort_direction), false )

    @ultima_especie = FiloEspecie.find_by(id: 478)
    unless @ultima_especie.blank?
      publicaciones = @ultima_especie.publicaciones.order(:year)
      @grafico = {}
      primero = publicaciones.first.year.to_i
      ultimo = publicaciones.last.year.to_i

      for valor in primero..ultimo do
        label = (valor/10).truncate()*10
        @grafico[label] = 0 if @grafico[label].blank?
      end

      publicaciones.each do |pub|
        label = (pub.year.to_i/10).truncate()*10
        @grafico[label] += 1 unless pub.year.blank?
      end
    end
  end

  def taxonomia
    if params[:indice].blank?
      base_ids = FiloElemento.all.map {|fe| fe.id unless (fe.parent.present? or fe.revisar == true)}.compact
      set_tabla('base-filo_elementos', FiloElemento.where(id: base_ids).order(:filo_elemento), false)
      @padres_ids = nil
    else
      @objeto = FiloElemento.find(params[:indice])

      set_tabla('base-filo_elementos', @objeto.children.order(:filo_elemento), false)
      set_tabla('filo_especies', @objeto.filo_especies.order(:filo_especie), false)

      @padres_ids = @objeto.padres_ids.reverse()
      @padres = @objeto.padres.reverse()

      if @objeto.parent.blank?
        hermanos_ids = FiloElemento.all.map {|elemento| elemento.id if elemento.parent.blank? and elemento.id != @objeto.id}.compact
      else
        hermanos_ids = @objeto.parent.children.map {|elem| elem.id unless elem.id == @objeto.id}.compact
      end
      @hermanos = FiloElemento.where(id: hermanos_ids).order(:filo_elemento)

    end      
  end

  def huerfanas
    set_tab( :tab, ['Etiquetas de sinónimos', 'Etiquetas por clasificar'] )

    if @options[:tab] == 'Etiquetas por clasificar'
      set_tabla('huerfanas-especies', Especie.where(filo_sinonimo_id:nil, filo_especie_id: nil).order(:especie), true)
    elsif @options[:tab] == 'Etiquetas de sinónimos'
      set_tabla('sinonimos-especies', Especie.where.not(filo_sinonimo_id: nil).order(:especie), true)
    end
  end

  def especies
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])

      # limpieza de relacion con sub-especie
      if @objeto.filo_esp_sinos.count != @objeto.filo_sinonimos.count
        sinonimos_ids = @objeto.filo_sinonimos.ids
        @objeto.filo_esp_sinos.each do |esp_sinos|
          esp_sinos.delete unless sinonimos_ids.include?(esp_sinos.filo_sinonimo_id)
        end
      end
      # limpieza de relacion con sub-especie
      if @objeto.child_relations.count != @objeto.children.count
        children_ids = @objeto.children.ids
        @objeto.child_relations.each do |child_rel|
          child_rel.delete unless children_ids.include?(child_rel.child_id)
        end
      end
      # limpieza de especies que son sinónimos de si mismas
      if @objeto.filo_sinonimos.map {|fs| fs.filo_sinonimo}.include?(@objeto.filo_especie)
        misma = @objeto.filo_sinonimos.find_by(filo_sinonimo: @objeto.filo_especie)
        e=misma.especie
        unless e.blank?
          e.filo_sinonimo_id = nil
          e.save
        end
        @objeto.filo_sinonimos.delete(misma)
      end

      set_tabla('filo_especies', @objeto.children.order(:filo_especie), false)

      set_tabla('equivalentes-filo_sinonimos', @objeto.fs_equivalentes, false)
      set_tabla('sinonimos-filo_sinonimos', @objeto.fs_sinonimos, false)
      set_tabla('excluidos-filo_sinonimos', @objeto.fs_excluidos, false)
      set_tabla('agregados-filo_sinonimos', @objeto.fs_agregados, false)

      set_tabla('filo_actualizaciones', @objeto.filo_actualizaciones.order(updated_at: :desc), false)

      set_tabla('app_imagenes', @objeto.imagenes, false)

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

      if @objeto.filo_elemento.present?
        @objeto.filo_elemento.padres_ids.reverse()
      elsif @objeto.parent.filo_elemento.present?
        @objeto.parent.filo_elemento.padres_ids.reverse()
      else
        []
      end
#      @padres_ids = @objeto.filo_elemento.present? ? @objeto.filo_elemento.padres_ids.reverse() : @objeto.parent.filo_elemento.padres_ids.reverse()

      @padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
#      @abuelo = @objeto.parent.present? ? @padre.filo_elemento : @padre.parent

      # En este caso puede haber HERMANOS ELEMENTOS/ESPECIES
      @hermanos_elementos = @objeto.parent.present? ? nil : @padre.children
      @hermanos_especies = @objeto.parent.present? ? nil : @padre.filo_especies
    end
  end

  def publicaciones
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])
      publicaciones = @objeto.publicaciones.order(:year)
      set_tabla("publicaciones", publicaciones, true)

      if publicaciones.count > 9
        @grafico = {}
        primero = publicaciones.first.year.to_i
        ultimo = publicaciones.last.year.to_i

        for valor in primero..ultimo do
          label = (valor/10).truncate()*10
          @grafico[label] = 0 if @grafico[label].blank?
        end

        publicaciones.each do |pub|
          label = (pub.year.to_i/10).truncate()*10
          @grafico[label] += 1 unless pub.year.blank?
        end
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
