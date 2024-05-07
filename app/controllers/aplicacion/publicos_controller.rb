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

  # Despliega Base de la estructura / filo_elemento específico
  def taxonomia
    if params[:indice].blank?

      # @objeto = nil

      # ids de los filo_elemento que no tienen padreg
      base_ids = FiloElemento.all.map {|fe| fe.id unless fe.parent.present?}.compact

      # Carga tabla base-filo_elementos
      set_tabla('filo_elementos', FiloElemento.where(id: base_ids).order(:filo_elemento), false)

      @padres = []

    else

      @objeto = FiloElemento.find(params[:indice])

      unless @objeto.blank?
        # Tabla de subelementos de @objeto
        set_tabla('filo_elementos', @objeto.children.order(:filo_elemento), false)
        # Tabla de especies de @objeto
        set_tabla('filo_especies', @objeto.filo_especies.order(:filo_especie), false)

        # lista de los padres para el link superior
        @padres = @objeto.padres.reverse()

        # Hermanos = hijos del mismo padre necesario para método 'subir'
        puts "********************************************************* proceso de @hermanos inicio "
        if @objeto.parent.blank?
          hermanos_ids = FiloElemento.all.map { |fe| fe.id if fe.parent.blank? and fe.id != @objeto.id }.compact
        else
          hermanos_ids = @objeto.parent.children.map {|elem| elem.id unless elem.id == @objeto.id}.compact
        end
        @hermanos = FiloElemento.where(id: hermanos_ids).order(:filo_elemento)
        puts "******************************************************** prooceso de @hermanos fin"
      end

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
    # No despliega nada sin un ìndice, no hay despliegue Base
    unless params[:indice].blank?
      @objeto = FiloEspecie.find(params[:indice])
      unless @objeto.blank?

        # limpieza de especies que son sinónimos de si mismas
        # REVISAR es posible que de no estar caiga en un loop
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

        filo_interacciones_ids = @objeto.filo_roles.map {|fr| fr.filo_interaccion_id}.uniq
        filo_interacciones = FiloInteraccion.where(id: filo_interacciones_ids).order(:created_at)
        especies_ids = @objeto.filo_roles.map {|fr| fr.filo_especie_id unless fr.filo_especie_id == @objeto.id}.uniq
        especies = FiloEspecie.where(id: especies_ids).order(:filo_especie)
        set_tabla('filo_especies', especies, false)
        set_tabla('filo_interacciones', filo_interacciones, false)
        publicaciones_ids = filo_interacciones.map {|fi| fi.publicacion_id}.uniq
        publicaciones = Publicacion.where(id: publicaciones_ids).order(:year)
        set_tabla('publicaciones', publicaciones, false)

        filo_def_interacciones_ids = filo_interacciones.map {|fi| fi.filo_def_interaccion_id}.uniq
        filo_def_interacciones = FiloDefInteraccion.where(id: filo_def_interacciones_ids).order(:filo_def_interaccion)
        set_tabla('filo_def_interacciones', filo_def_interacciones, false)

        set_tabla('filo_actualizaciones', @objeto.filo_actualizaciones.order(updated_at: :desc), false)

        set_tabla('app_imagenes', @objeto.imagenes, false)

        regiones_para_asignar_ids = Region.all.map {|region| region.id unless @objeto.regiones.ids.include?(region.id)}.compact
        @regiones_para_asignar = Region.where(id: regiones_para_asignar_ids).order(:orden)

        @padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
        @padres = @objeto.padres.reverse()

        # En este caso puede haber HERMANOS ELEMENTOS/ESPECIES
        @hermanos_elementos = @objeto.parent.present? ? nil : @padre.children
        @hermanos_especies = @objeto.parent.present? ? nil : @padre.filo_especies

      end
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

  # Copia de publicaciones#show
  # GET /publicos/publicacion?pid=publicacion.id"
  # GET /publicaciones/1
  # GET /publicaciones/1.json
  def publicacion
    @objeto = Publicacion.find(params[:pid])
    unless @objeto.blank?
      # Seleccionador de Àreas, Categorías, Carpetas y Compartidas
      areas_disponibles_ids = Area.all.map {|area| area.id unless @objeto.areas.ids.include?(area.id)}.compact
      @sel_areas = Area.where(id: areas_disponibles_ids).order(:area)

      categorias_disponibles_ids = Categoria.all.map {|categoria| categoria.id unless @objeto.categorias.ids.include?(categoria.id)}.compact
      @sel_categorias = Categoria.where(id: categorias_disponibles_ids)

      unless perfil_activo.blank?
        # Carpetas del perfil
        @carpetas_perfil = perfil_activo.carpetas.order(:carpeta)
        # Carpetas del objeto que son del perfil de usuario
        @carpetas = @objeto.carpetas.where(id: @carpetas_perfil.ids).order(:carpeta)
        @carpetas_ids = @carpetas.ids
        # Carpetas compartidas del perfil
        @compartidas_perfil = perfil_activo.compartidas.order(:carpeta)
        # Carpetas del objeto que son de las compartidas del perfil
        @compartidas = @objeto.carpetas.where(id: @compartidas_perfil.ids)
        @compartidas_ids = @compartidas.ids
      end

      @etiquetas = @objeto.especies.order(:especie)
      @sets = @objeto.eco_sets.order(created_at: :desc)
      @interacciones = @objeto.filo_interacciones.order(:created_at)

      # ********************** DUPLICADOS *****************************
      duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
      duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

      @duplicados_doi = Publicacion.where(id: duplicados_doi_ids)
      @duplicados_t_sha1 = Publicacion.where(id: duplicados_t_sha1_ids)
      # ********************** DUPLICADOS *****************************

      set_tabla('app_observaciones', @objeto.observaciones.order(created_at: :desc), false)
      set_tabla('app_mejoras', @objeto.mejoras.order(created_at: :desc), false)
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
