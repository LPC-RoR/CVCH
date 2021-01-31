class VistasController < ApplicationController
  before_action :authenticate_usuario!, only: [:escritorio]
  before_action :inicia_session
  before_action :set_vista, only: [:show, :edit, :update, :destroy]
  before_action :check_areas, only: [:index]

  # GET /vistas
  # GET /vistas.json
  def index
    # BI FRAME
    # Lista de 'selectors'
    @frame_selector = Area.all.map {|a| [a.area, a.papers.count]}
    # CONTROLADOR de la tabla a depslegar
    @table_controller = 'publicaciones'

    # ftab
    if params[:html_options].blank?
      @ftab = 'Completa'
      @area = Area.first
    else
      @ftab = (params[:html_options]['ftab'].blank? or session[:perfil_activo].blank?) ? 'Completa' : params[:html_options]['ftab']
      @area = params[:html_options]['sel'].blank? ? Area.first : Area.find_by(area: params[:html_options]['sel'])
    end
    # selector activo
    @sel = @area.area
    # opciones para los links
    @options = {'sel' => @sel ,'ftab' => @ftab}

    if @ftab == 'Completa'
      @coleccion = @area.papers.where(estado: 'publicada').page(params[:page])
    elsif @ftab == 'Pendiente'
      @activo = Perfil.find(session[:perfil_activo]['id'])
      @propios_ids = []
      @activo.carpetas.each do |car|
        @propios_ids = @propios_ids.union(car.publicaciones.ids)
      end
      @area_completa_ids = @area.papers.ids
      @coleccion = Publicacion.where(id: @area_completa_ids - @propios_ids).where(estado: 'publicada').page(params[:page])
    end
  end

  def escritorio
    # BI FRAME
    # Lista de 'selectors'
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @frame_selector = @activo.carpetas.all.map {|c| [c.carpeta, c.publicaciones.count]}
    # CONTROLADOR de la tabla a depslegar
    @table_controller = 'publicaciones'

    # ftab
    if params[:html_options].blank?
#      @ftab = 'Completa'
      @carpeta = @activo.carpetas.first
    else
#      @ftab = params[:html_options]['ftab'].blank? ? 'Completa' : params[:html_options]['ftab']
      @carpeta = params[:html_options]['sel'].blank? ? @activo.carpetas.first : @activo.carpetas.find_by(carpeta: params[:html_options]['sel'])
    end
    # selector activo
    @sel = @carpeta.carpeta
    # opciones para los links
    @options = {'sel' => @sel}

    @coleccion = @carpeta.publicaciones.page(params[:page])
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
