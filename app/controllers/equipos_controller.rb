class EquiposController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_equipo, only: [:show, :edit, :update, :destroy, :elimina_equipo]

  # GET /equipos
  # GET /equipos.json
  def index
    @activo = perfil_activo
  end

  # GET /equipos/1
  # GET /equipos/1.json
  def show
    session[:equipo_id] = @objeto.id
    @activo = perfil_activo

    if params[:html_options].blank?
      @tab = 'carpetas'
    else
      @tab = params[:html_options][:tab].blank? ? 'carpetas' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = {}
    @coleccion['app_perfiles'] = @objeto.app_perfiles
    @coleccion['carpetas'] = @objeto.carpetas

    ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
    @carpetas_seleccion = Carpeta.find(ids_carpetas_tema - @objeto.carpetas.ids)
  end

  # GET /equipos/new
  def new
    @objeto = Equipo.new
  end

  def nuevo
    unless params[:nuevo_equipo][:equipo].blank?
      activo = perfil_activo

      texto_sha1 = perfil_activo.email+params[:nuevo_equipo][:equipo]
      sha1 = Digest::SHA1.hexdigest(texto_sha1)
      equipo = activo.equipos.create(equipo: params[:nuevo_equipo][:equipo], sha1: sha1)

    end

    redirect_to equipos_path
  end

  def participa
    unless params[:participa_equipo][:equipo].blank?
      activo = perfil_activo

      sha1 = params[:participa_equipo][:equipo]
      equipo = Equipo.find_by(sha1: sha1)
      unless equipo.blank?
        activo.participaciones << equipo
      end

    end
    redirect_to equipos_path
  end

  def nueva_carpeta_equipo
    @equipo  = Equipo.find(params[:equipo_id])
    @carpeta = Carpeta.find(params[:carpeta_base][:carpeta_id])

    @equipo.carpetas << @carpeta unless @equipo.carpetas.ids.include?(@carpeta.id)

    redirect_to @equipo
  end

  # GET /equipos/1/edit
  def edit
  end

  # POST /equipos
  # POST /equipos.json
  def create
    @objeto = Equipo.new(equipo_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Equipo was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipos/1
  # PATCH/PUT /equipos/1.json
  def update
    respond_to do |format|
      if @objeto.update(equipo_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Equipo was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipos/1
  # DELETE /equipos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Equipo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina_equipo
    @activo = perfil_activo
    @objeto.delete
    redirect_to @objeto
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipo
      @objeto = Equipo.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/equipos'
    end

    # Only allow a list of trusted parameters through.
    def equipo_params
      params.require(:equipo).permit(:equipo, :sha1, :administrador_id)
    end
end
