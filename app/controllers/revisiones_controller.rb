class RevisionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_revision, only: [:show, :edit, :update, :destroy]

    helper_method :sort_column, :sort_direction

# GET /revisiones
  # GET /revisiones.json
  def index
    if params[:html_options].blank?
      @tab = 'Cargas'
      @area = session[:area].blank? ? Area.first : Area.find_by(area: session[:area])
    else
      @tab = params[:html_options]['tab'].blank? ? 'Cargas' : params[:html_options]['tab']
      #@area = params[:html_options]['sel'].blank? ? Area.first : Area.find_by(area: params[:html_options]['sel'])
      @area = Area.find_by(area: params[:html_options]['sel'])
      session[:area] = @area.area if session[:area] != @area.area
    end

    # Lista de 'selectors'
    @list_selector = Area.all.map {|a| [a.area, a.papers.where(estado: @tab.singularize.downcase).count]}

    # selector activo
    @sel = @area.area
    # opciones para los links
    @options = {'sel' => @sel ,'tab' => @tab}

    @coleccion = {}
    @coleccion['publicaciones'] = (@tab == 'Contribuciones' ? Publicacion.where(estado: 'contribucion').order(sort_column + " " + sort_direction).page(params[:page]) : @area.papers.where(estado: @tab.singularize.downcase).order(sort_column + " " + sort_direction).page(params[:page]))

  end

  # GET /revisiones/1
  # GET /revisiones/1.json
  def show
  end

  # GET /revisiones/new
  def new
    @objeto = Revision.new
  end

  # GET /revisiones/1/edit
  def edit
  end

  # POST /revisiones
  # POST /revisiones.json
  def create
    @objeto = Revision.new(revision_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Revision was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revisiones/1
  # PATCH/PUT /revisiones/1.json
  def update
    respond_to do |format|
      if @objeto.update(revision_params)
        format.html { redirect_to @objeto, notice: 'Revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revisiones/1
  # DELETE /revisiones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to revisiones_url, notice: 'Revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revision
      @objeto = Revision.find(params[:id])
    end

    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Only allow a list of trusted parameters through.
    def revision_params
      params.fetch(:revision, {})
    end
end
