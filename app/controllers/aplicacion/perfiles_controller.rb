class Aplicacion::PerfilesController < ApplicationController
  before_action :authenticate_usuario!, except: :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]

  # GET /perfiles
  # GET /perfiles.json
  def index
    if session[:perfil_activo] == session[:perfil_base]
      @activo = Perfil.find(session[:perfil_activo]['id'])
      @coleccion = Perfil.where(id: @activo.equipos.map {|e| e.perfil.id})
    else
      @coleccion = Perfil.where(id: session[:perfil_base]['id'])
    end
  end

  # GET /perfiles/1
  # GET /perfiles/1.json
  def show
    session[:perfil_activo] = @objeto
    redirect_to '/perfiles'
  end

  # GET /perfiles/new
  def new
    @objeto = Perfil.new
  end

  # GET /perfiles/1/edit
  def edit
  end

  # POST /perfiles
  # POST /perfiles.json
  def create
    @objeto = Perfil.new(perfil_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Perfil was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfiles/1
  # PATCH/PUT /perfiles/1.json
  def update
    respond_to do |format|
      if @objeto.update(perfil_params)
        format.html { redirect_to @objeto, notice: 'Perfil was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles/1
  # DELETE /perfiles/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to perfiles_url, notice: 'Perfil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil
      @objeto = Perfil.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def perfil_params
      params.require(:perfil).permit(:usuario_id, :administrador_id, :investigador_id, :equipo_id)
    end
end
