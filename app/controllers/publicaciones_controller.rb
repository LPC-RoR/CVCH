class PublicacionesController < ApplicationController
  before_action :set_publicacion, only: [:show, :edit, :update, :destroy]

  # GET /publicaciones
  # GET /publicaciones.json
  def index
    @frame_selector = Area.all.map {|a| a.area}
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

    # agrega contexto SELF
    @self = Investigador.find(session[:perfil]['id'])
    unless ['ingreso', 'carga'].include?(@objeto.estado)
      @carpetas_destino = Carpeta.find(@self.carpetas.all.ids - @objeto.carpetas.ids)
    end
end

  # GET /publicaciones/new
  def new
    @objeto = Publicacion.new
  end

  def mask_new
    @origen = params[:origen]
  end

  def mask_nuevo
    @investigador = Investigador.find(session[:perfil]['id'])
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

    @investigador.contribuciones << @objeto

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

  def cambia_tipo
    @publicacion = Publicacion.find(params[:publicacion_id])
    @publicacion.doc_type = params[:doc_type]
    @publicacion.save

    redirect_to @publicacion
  end

  def estado
    @publicacion = Publicacion.find(params[:publicacion_id])
    @publicacion.estado = params[:estado]
    @publicacion.save

    if params[:estado] == 'publicada'
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
    def set_publicacion
      @objeto = Publicacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publicacion_params
      params.require(:publicacion).permit(:unique_id, :origen, :title, :author, :doi, :year, :volume, :pages, :month, :publisher, :abstract, :link, :author_email, :issn, :eissn, :address, :affiliation, :article_number, :keywords, :keywords_plus, :research_areas, :web_of_science_categories, :da, :d_journal, :d_author, :d_doi, :registro_id, :revista_id, :equipo_id, :investigador_id, :academic_degree, :estado)
    end
end
