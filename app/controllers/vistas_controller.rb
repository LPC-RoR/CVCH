class VistasController < ApplicationController
  before_action :authenticate_usuario!, only: [:escritorio]
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_vista, only: [:show, :edit, :update, :destroy]
  before_action :check_areas, only: [:index]

  helper_method :sort_column, :sort_direction

  # GET /vistas
  # GET /vistas.json
  def index
    @list_selector = Area.all.map {|a| [a.area, a.papers.count]}

    if params[:html_options].blank?
      #Recordar el lugar si se vuelve a entrar a Colección
      @area = session[:area].blank? ? Area.first : Area.find_by(area: session[:area])
      params[:page] = session[:page] unless (session[:page].blank? or params[:page] == 2)
    else
      @area = Area.find_by(area: params[:html_options]['sel'])
      unless session[:area] == params[:html_options]['sel']
        params[:page] = nil 
        session[:area] = @area.area
      end
    end
    session[:page] = params[:page]

    # selector activo
    @sel = @area.area
    # opciones para los links
    @options = {'sel' => @sel}

    @coleccion = {}
    @coleccion['publicaciones'] = @area.papers.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page])
  end

  def escritorio
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @list_selector = @activo.carpetas.all.map {|c| [c.carpeta, c.publicaciones.count]}

    @tabs = ['Publicaciones', 'Citas']

    if params[:html_options].blank?
      @carpeta = @activo.carpetas.first
      @tab = 'Publicaciones'
    else
      @carpeta = params[:html_options]['sel'].blank? ? @activo.carpetas.first : @activo.carpetas.find_by(carpeta: params[:html_options]['sel'])
      @tab = params[:html_options]['tab'].blank? ? 'Publicaciones' : params[:html_options]['tab']
    end

    @sel = @carpeta.carpeta
    @options = {'sel' => @sel, 'tab' => @tab}

    @coleccion = {}
    @coleccion['publicaciones'] = @carpeta.publicaciones.order(sort_column + " " + sort_direction).page(params[:page]) if @tab == 'Publicaciones'
    @coleccion['citas']  = @carpeta.publicaciones.order(:author)

    @coleccion['carpetas'] = @activo.carpetas
  end

  # GET /vistas/1
  # GET /vistas/1.json
  def show
  end

  # GET /vistas/new
  def new
    @objeto = Vista.new
  end

  # GET /vistas/1/edit
  def edit
  end

  # POST /vistas
  # POST /vistas.json
  def create
    @objeto = Vista.new(vista_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Vista was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vistas/1
  # PATCH/PUT /vistas/1.json
  def update
    respond_to do |format|
      if @objeto.update(vista_params)
        format.html { redirect_to @objeto, notice: 'Vista was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vistas/1
  # DELETE /vistas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to vistas_url, notice: 'Vista was successfully destroyed.' }
      format.json { head :no_content }
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

    def set_vista
      @objeto = Vista.find(params[:id])
    end

    def check_areas
      if Area.all.empty?
        Area::NOT_MODIFY.each do |area|
          Area.create(area: area)
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def vista_params
      params.fetch(:vista, {})
    end
end
