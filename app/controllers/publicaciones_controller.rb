class PublicacionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy]
  after_action :procesa_author, only: [:update, :create]
  after_action :procesa_sha1, only: [:update, :create]
  after_action :procesa_journal, only: [:update, :create]
  after_action :procesa_estado, only: [:update, :create]
  after_action :procesa_doi, only: [:update, :create]
  after_action :asocia_contribucion, only: [:create]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    @tab = params[:tab].blank? ? 'Revisar' : params[:tab]
    @carpeta = Carpeta.find_by(carpeta: @tab)
    if @carpeta.blank?
      Carpeta.create(carpeta: 'Revisar')
    end
    @coleccion = @carpeta.publicaciones.page(params[:page])
  end

  # GET /publicaciones/1
  # GET /publicaciones/1.json
  def show
#    @tab = params[:tab].blank? ? 'textos' : params[:tab]
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
#    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)

    # ********************** DUPLICADOS *****************************

    @duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
    @duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

    @duplicados_ids = @duplicados_doi_ids.union(@duplicados_t_sha1_ids)

    unless @duplicados_ids.empty?
      @duplicados = Publicacion.where(id: @duplicados_ids)
    end

    # ********************** DUPLICADOS *****************************

    @menu_areas = Area.where(id: Area.all.ids - @objeto.areas.ids)

    @activo = Perfil.find(session[:perfil_activo]['id'])
    # Aqui me gano los porotos. El manejo de carpetas
    # Voy a hacer dos columnas
    # IZQ las carpetas en las cuales la Publicacion está
    # DER las carpetas en las que se puede agregar
    # CARPETAS EN LAS QUE ESTÁ (Propias + Equipo)
    # 1.- los ids de las carpetas de @activo se dividen en @carpetas_base @carpetas_tema
    @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

    @id_carpeta_revisadas = @activo.carpetas.find_by(carpeta: 'Revisadas').id
    # QUE GACEMOS CON LAS CARPETAS DE LOS EQUIPOS A LOS QUE PERTENECEMOS ??
    # HAREMOS EL PERFIL DEL USUARIO E IMPLEMENTAREMOS BOTONES PARA CAMBIAR DE PERFIL

    # Tomamos de las carpetas de la publicacion SOLO las que pertenecen a SELF
    @ids_carpetas_publicacion = @objeto.carpetas.ids.intersection(@activo.carpetas.ids) 

    @ids_actual_base = @ids_carpetas_base.intersection(@ids_carpetas_publicacion)
    @ids_actual_tema = @ids_carpetas_tema.intersection(@ids_carpetas_publicacion)

    # El primer caso es cuando NO esta en NINGUNA CARPETA
    if @ids_carpetas_publicacion.empty?
      @carpetas_actuales  = nil
      @carpetas_destino = Carpeta.where(id: @ids_carpetas_base)
    elsif @ids_actual_tema.empty?
      # En este caso tenemos dos casos distintos 
      # 1.- El tema es "Revisada" ? Se pueden agregar carpetas Personalizadas
      # 2.- Otro tema : Solo se puede cambiar de Carpeta base
      if @ids_actual_base.include?(@id_carpeta_revisadas)
        @carpetas_actuales = Carpeta.where(id: @ids_actual_base)
        @carpetas_destino  = Carpeta.where(id: @ids_carpetas_base.union(@ids_carpetas_tema) - @ids_actual_base)
      else
        @carpetas_actuales = Carpeta.where(id: @ids_actual_base)
        @carpetas_destino  = Carpeta.where(id: @ids_carpetas_base - @ids_actual_base)
      end
    else
      # En este caso SOLO se pueden AGREGAR o QUITAR Carpetas TEMA
      @carpetas_actuales = Carpeta.where(id: @ids_actual_base.union(@ids_actual_tema))
      @carpetas_destino  = Carpeta.where(id: @ids_carpetas_tema - @ids_actual_tema)
    end


    @areas_actuales = @objeto.areas
    @ids_areas_destino = Area.all.ids - @areas_actuales.ids
    @areas_destino = Area.where(id: @ids_areas_destino)

    @tab = 'instancias'
    @tl_coleccion = @objeto.instancias
    @options = {'tab' => @tab}
      
  end

  # GET /publicaciones/new
  def new
    @objeto = Publicacion.new(estado: 'ingreso')
  end

  def mask_new
    @origen = params[:origen]
  end

  def mask_nuevo
    @activo = Perfil.find(session[:perfil_activo]['id'])
    # en esta aplicación NO hay dos orígenes posibles SOLO uno
#    @origen = params[:origen] == 'equipos' ? 'Produccion' : 'Manual'

    # TITULO
    @title = params[:m_params][:title].strip
    # AUTORES
    # 1.- Sacar los caracteres que referencian institucion donde trabaja el investigador
    # 2.- Se almacena en 'author' sólo el autor corregido sin las citas
    # Me quedó más linda que la mierda
    @author = limpia_autor_ingreso(params[:m_params][:author].strip)

    # 3.- Sacamos el Nombre de la Revista
    match_1 = params[:m_params][:journal].strip.match(/(?<revista>[^\d\(\):–]*) (?<resto>[\d\(\):–\s,]*)/)
    @journal = match_1[:revista]
    resto_1 = match_1[:resto].strip

    # 4.- Sacamos el volumen y el año
    match_2 = resto_1.split(':').join(' ').match(/(?<r1>[\d\(\):–,]*) (?<r2>[\d\(\):–,]*) (?<r3>[\d\(\):–\s,]*)/)
    if !!match_2[:r1].strip.match(/\(\d*\)/)
      match_3 = match_2[:r1].strip.match(/\((?<year>\d*)\)/)
      @volume = match_2[:r2].strip.delete_suffix(',')
    else
      match_3 = match_2[:r2].strip.match(/\((?<year>\d*)\)/)
      @volume = match_2[:r1].strip.delete_suffix(',')
    end
    @year = match_3[:year]
    @pages = match_2[:r3].strip

    # DOI
    # 1.- revisar d_doi y sacar la url o el doi: segun corrsponda.
    primer_filtro_doi = params[:m_params][:doi].strip.delete_prefix('DOI').delete_prefix('doi:').strip
    @doi = !!primer_filtro_doi.match(/doi.org/) ? primer_filtro_doi.strip.split('doi.org/')[1] : primer_filtro_doi

    # ABSTRACT
    @abstract = params[:m_params][:abstract].strip
    @objeto = Publicacion.create(origen: 'ingreso', estado: 'ingreso', title: @title, author: @author, d_journal: @journal, volume: @volume, year: @year, pages: @pages, doi: @doi, abstract: @abstract)

    @activo.contribuciones << @objeto

    redirect_to @objeto
  end

  # GET /publicaciones/1/edit
  def edit
  end

  # POST /publicaciones
  # POST /publicaciones.json
  def create
    @objeto = Publicacion.new(publicacion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Publicacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publicaciones/1
  # PATCH/PUT /publicaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(publicacion_params)
        format.html { redirect_to @objeto, notice: 'Publicacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambia_area
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = Publicacion.find(params[:html_options][:publicacion_id])
    @area   = Area.find(params[:html_options][:area_id])

    case params[:html_options][:origen]
    when 'actuales'
      @objeto.areas.delete(@area)
    when 'destinos'
      @objeto.areas << @area
    end

    redirect_to @objeto

  end

  def cambia_carpeta
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = Publicacion.find(params[:html_options][:publicacion_id])
    @carpeta = Carpeta.find(params[:html_options][:carpeta_id])

    @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

    @id_carpeta_revisadas = @activo.carpetas.find_by(carpeta: 'Revisadas').id

    @ids_carpetas_publicacion = @objeto.carpetas.ids.intersection(@activo.carpetas.ids) 

    @ids_actual_base = @ids_carpetas_base.intersection(@ids_carpetas_publicacion)
    @ids_actual_tema = @ids_carpetas_tema.intersection(@ids_carpetas_publicacion)

    case params[:html_options][:origen]
    when 'actuales'
      # En este caso sólo tienen link las carpetas tema y lo único que hay que hacer es eliminarlas
      @objeto.carpetas.delete(@carpeta)
    when 'destinos'
      if @ids_carpetas_base.include?(params[:html_options][:carpeta_id].to_i)
        @cars = Carpeta.where(id: @ids_actual_base)
        @cars.each do |cc|
          @objeto.carpetas.delete(cc)
        end
      end
      @objeto.carpetas << @carpeta
    end

    redirect_to @objeto
  end

  def cambia_tipo
    @publicacion = Publicacion.find(params[:publicacion_id])
    @publicacion.doc_type = params[:doc_type]
    @publicacion.save

    redirect_to @publicacion
  end

  def estado
    @publicacion = Publicacion.find(params[:publicacion_id])
    if params[:estado] == 'eliminado'
      # Tiene dos has_many Through
      # 1.- cargas, through: procesos
      # 2.- areas, through: asignaciones
      @area = @publicacion.areas.first
      @carga = @publicacion.cargas.first if @publicacion.origen == 'carga'
      @area.papers.delete(@publicacion) unless @area.blank?
      unless @carga.blank?
        @carga.publicaciones.delete(@publicacion) if @publicacion.origen == 'carga'
      end
      @publicacion.delete
    elsif params[:estado] == 'correccion'
      @publicacion.estado = (@publicacion.origen == 'carga' ? 'carga' : 'contribucion')
      @publicacion.unicidad = 'unico'
      @publicacion.save
    elsif params[:estado] == 'multiple'
      @publicacion.estado = 'publicada'
      @publicacion.unicidad = 'multiple'
      @publicacion.save
    else
      @publicacion.estado = params[:estado]
      @publicacion.save
    end

    if @publicacion.estado == 'publicada'
      procesa_cita_carga(@publicacion)
    end

    redirect_to "/revisiones"
  end

  # DELETE /publicaciones/1
  # DELETE /publicaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to publicaciones_url, notice: 'Publicacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def procesa_author
      if @objeto.d_author.present?
        @objeto.author = limpia_autor_ingreso(@objeto.d_author)
        @objeto.save
      end
    end

    def procesa_journal
      # Puede estar el volumen antes o despues del año
      if @objeto.d_journal.present?
        match_year = @objeto.d_journal.strip.match(/(?<anterior>[^\(]*) \((?<year>\d{4})\) (?<siguiente>.*)/)
        anterior = match_year[:anterior].strip
        siguiente = match_year[:siguiente].strip
        if !!anterior.match(/\d+/)
          # la revista tienen el volumen
          match_journal_volume = anterior.strip.match(/(?<journal>\D*) (?<volume>\d*)/)
          @objeto.journal = match_journal_volume[:journal].strip
          @objeto.volume = match_journal_volume[:volume].strip
          @objeto.pages = siguiente
        else
          @objeto.journal = anterior

          if siguiente.split(':').length == 2
            @objeto.volume = siguiente.split(':')[0].strip
            @objeto.pages = siguiente.split(':')[1].strip
          elsif siguiente.split(',').length == 2
            @objeto.volume = siguiente.split(',')[0].strip
            @objeto.pages = siguiente.split(',')[1].strip
          else
            @objeto.volume = ''
            @objeto.pages = siguiente
          end
        end
        @objeto.year = match_year[:year]

        @objeto.save
      end
    end

    def procesa_doi
      if @objeto.d_doi.present?
        primer_filtro_doi = @objeto.d_doi.strip.delete_prefix('DOI').delete_prefix('doi:').strip
        @objeto.doi = !!primer_filtro_doi.match(/doi.org/) ? primer_filtro_doi.strip.split('doi.org/')[1] : primer_filtro_doi
        @objeto.save
      end
    end

    def procesa_sha1
      unless @objeto.title.blank?
        @t_sha1 = Digest::SHA1.hexdigest(@objeto.title.downcase)
        unless @objeto.t_sha1 == @t_sha1
          @objeto.t_sha1 = @t_sha1
          @objeto.save
        end
      end
    end

    def procesa_estado
      @duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
      @duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

      @duplicados_ids = @duplicados_doi_ids.union(@duplicados_t_sha1_ids)

      if @duplicados_ids.empty?
        if @objeto.estado == 'duplicado'
          @objeto.estado = @objeto.origen == 'carga' ? 'carga' : 'contribucion'
          @objeto.save
        end
      else
        if @objeto.unicidad == 'multiple'
          @objeto.estado = @objeto.origen == 'carga' ? 'carga' : 'contribucion'
        else
          @objeto.estado = 'duplicado'
        end
        @objeto.save
      end
    end

    def asocia_contribucion
      @activo = Perfil.find(session[:perfil_activo]['id'])
      @activo.contribuciones << @objeto
    end

    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publicacion_params
      params.require(:publicacion).permit(:unique_id, :origen, :title, :author, :doi, :year, :volume, :pages, :month, :publisher, :abstract, :link, :author_email, :issn, :eissn, :address, :affiliation, :article_number, :keywords, :keywords_plus, :research_areas, :web_of_science_categories, :da, :d_journal, :d_author, :d_doi, :registro_id, :revista_id, :equipo_id, :investigador_id, :academic_degree, :estado, :book, :doc_type, :editor, :ciudad_pais, :journal)
    end
end
