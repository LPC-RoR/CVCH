class PublicacionesController < ApplicationController

  include ProcesaCarga

  before_action :authenticate_usuario!, except: :show
  before_action :inicia_session
  before_action :carga_temas_ayuda
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy]

  after_action :procesa_author, only: [:update, :create]
  after_action :procesa_sha1, only: [:update, :create]
  after_action :procesa_journal, only: [:update, :create]
  after_action :procesa_estado, only: [:update, :create]
  after_action :procesa_doi, only: [:update, :create]

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

    @coleccion = {}

    if usuario_signed_in?

      @activo = Perfil.find(session[:perfil_activo]['id'])


      # ********************** CARPETAS *****************************
      if @objeto.estado == 'publicada'

        ## AMBOS
        @ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
        @ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact

        # ids de las carpetas del @activo
        ids_activo = @ids_carpetas_base | @ids_carpetas_tema

        # ids de la publicación que son del perfil
        ids_publicacion = @objeto.carpetas.ids & ids_activo

        @id_carpeta_revisadas  = @activo.carpetas.find_by(carpeta: 'Revisadas').id

        ids_todas = @ids_carpetas_base | @ids_carpetas_tema

        if ids_publicacion.empty?
          ids_seleccion = @ids_carpetas_base
        elsif (ids_publicacion.include?(@id_carpeta_revisadas) and ((ids_publicacion & @ids_carpetas_tema).empty?))
          ids_seleccion = ids_todas - [@id_carpeta_revisadas]
        elsif (@ids_carpetas_tema & ids_publicacion).any?
          ids_seleccion = @ids_carpetas_tema - ids_publicacion
        else
          ids_seleccion = @ids_carpetas_base - (@ids_carpetas_base & ids_publicacion)
        end

        @carpetas_seleccion = Carpeta.find(ids_seleccion)

        @coleccion['carpetas'] = @objeto.carpetas

      end
      if @activo.administrador.present?

        @areas_seleccion = Area.find(Area.all.ids - @objeto.areas.ids)

        @coleccion['areas'] = @objeto.areas

      end

      @coleccion['rutas'] = @objeto.rutas.order(:created_at)
      @coleccion['propuestas'] = @objeto.propuestas.order(:created_at)

    end

    # ********************** DUPLICADOS *****************************

    @duplicados_doi_ids = @objeto.doi.present? ? (Publicacion.where(doi: @objeto.doi).ids - [@objeto.id]) : []
    @duplicados_t_sha1_ids = @objeto.title.present? ? (Publicacion.where(t_sha1: @objeto.t_sha1).ids - [@objeto.id]) : []

    @duplicados_ids = @duplicados_doi_ids.union(@duplicados_t_sha1_ids)

    unless @duplicados_ids.empty?
      @duplicados = Publicacion.where(id: @duplicados_ids)
    end

    @coleccion['observaciones'] = @objeto.observaciones.order(created_at: :desc)
    @coleccion['mejoras'] = @objeto.mejoras.order(created_at: :desc)

  end

  # GET /publicaciones/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.contribuciones.new(origen: 'ingreso', estado: 'ingreso')
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

  def cambia_tipo
    @publicacion = Publicacion.find(params[:publicacion_id])
    @publicacion.doc_type = params[:doc_type]
    @publicacion.save

    redirect_to @publicacion
  end

  def cambia_evaluacion
    @activo = Perfil.find(session[:perfil_activo]['id'])
#    @objeto = Publicacion.find(params[:publicacion_id])

    @evaluacion = @objeto.evaluaciones.find_by(aspecto: params[:item], perfil_id: @activo.id)
    if @evaluacion.blank?
      @objeto.evaluaciones.create(aspecto: params[:item], evaluacion: params[:evaluacion], perfil_id: @activo.id)
    else
      @evaluacion.evaluacion = params[:evaluacion]
      @evaluacion.save
    end
    redirect_to @objeto
    
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

      @publicacion.investigadores.delete_all unless @publicacion.investigadores.empty?

      unless @publicacion.revista.blank?
        revista = @publicacion.revista
        revista.publicaciones.delete(@publicacion)
        revista.delete if revista.publicaciones.empty?
      end

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

    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through. 
    def publicacion_params
      params.require(:publicacion).permit(:unique_id, :origen, :title, :author, :doi, :year, :volume, :pages, :month, :publisher, :abstract, :link, :author_email, :issn, :eissn, :address, :affiliation, :article_number, :keywords, :keywords_plus, :research_areas, :web_of_science_categories, :da, :d_journal, :d_author, :d_doi, :registro_id, :revista_id, :equipo_id, :investigador_id, :academic_degree, :estado, :book, :doc_type, :editor, :ciudad_pais, :journal, :perfil_id)
    end
end
