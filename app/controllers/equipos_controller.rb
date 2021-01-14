class EquiposController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_equipo, only: [:show, :edit, :update, :destroy, :elimina_equipo]

  # GET /equipos
  # GET /equipos.json
  def index
    if params[:html_options].blank?
      @tab = 'Administrados'
    else
      @tab = params[:html_options][:tab].blank? ? 'Administrados' : params[:html_options][:tab]
    end

    @activo = Perfil.find(session[:perfil_activo]['id'])

    @coleccion = (@tab == 'Administrados') ? @activo.equipos : @activo.participaciones

    @options = {'tab' => @tab}
  end

  # GET /equipos/1
  # GET /equipos/1.json
  def show
    session[:equipo_id] = @objeto.id
    if params[:html_options].blank?
      @tab = 'carpetas'
    else
      @tab = params[:html_options][:tab].blank? ? 'carpetas' : params[:html_options][:tab]
    end
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
    @options = {'tab' => @tab}
  end

  # GET /equipos/new
  def new
    @objeto = Equipo.new
  end

  def nuevo
    unless params[:nuevo_equipo][:equipo].blank?
      @activo = Perfil.find(session[:perfil_activo]['id'])
      case params[:tab]
      when 'Administrados'
        @texto_sha1 = session[:perfil_activo]['email']+params[:nuevo_equipo][:equipo]
        @sha1 = Digest::SHA1.hexdigest(@texto_sha1)
        @equipo = @activo.equipos.create(equipo: params[:nuevo_equipo][:equipo], sha1: @sha1)
        @perfil = Perfil.create(equipo_id: @equipo.id)

        # Llenado de carpetas BASE
        Carpeta::NOT_MODIFY.each do |c|
          @equipo.carpetas.create(carpeta: c)
        end
      when 'Participaciones'
        @sha1 = params[:nuevo_equipo][:equipo]
        @equipo = Equipo.find_by(sha1: @sha1)
        unless @equipo.blank?
          @activo.asociaciones << @equipo
        end
      end

    end
    redirect_to "/equipos?tab=#{params[:tab]}"
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
    @activo = Perfil.find(session[:perfil_activo]['id'])
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
