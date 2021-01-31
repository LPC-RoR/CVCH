class CarpetasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy]

  # GET /carpetas
  # GET /carpetas.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @coleccion =  session[:perfil_activo] == session[:perfil_base] ? @coleccion = @activo.carpetas : @coleccion = @activo.equipo.carpetas
    end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'publicaciones'
    else
      @tab = params[:html_options][:tab].blank? ? 'publicaciones' : params[:html_options][:tab]
    end
    @coleccion = @objeto.send(@tab).page(params[:page])
    @options = {'tab' => @tab}
  end

  # GET /carpetas/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.carpetas.new
  end

  def nuevo
    @equipo = Equipo.find(params[:equipo_id])
    if params[:nueva_carpeta][:carpeta].present?
      @equipo.carpetas << Carpeta.create(carpeta: params[:nueva_carpeta][:carpeta])
    end
    redirect_to @equipo
  end

  # GET /carpetas/1/edit
  def edit
  end

  # POST /carpetas
  # POST /carpetas.json
  def create
    @objeto = Carpeta.new(carpeta_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpetas/1
  # PATCH/PUT /carpetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(carpeta_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpetas/1
  # DELETE /carpetas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Carpeta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpeta
      @objeto = Carpeta.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/carpetas'
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :perfil_id, :equipo_id)
    end
end
