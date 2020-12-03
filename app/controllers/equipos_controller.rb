class EquiposController < ApplicationController
  before_action :set_equipo, only: [:show, :edit, :update, :destroy]

  # GET /equipos
  # GET /equipos.json
  def index
    @tab = params[:tab].blank? ? 'Administrados' : params[:tab]

    @self = Investigador.find(session[:perfil]['id'])

    @coleccion = (@tab == 'Administrados') ? @self.equipos : @self.participaciones

    @options = {'tab' => @tab}
  end

  # GET /equipos/1
  # GET /equipos/1.json
  def show
  end

  # GET /equipos/new
  def new
    @objeto = Equipo.new
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
        format.html { redirect_to @objeto, notice: 'Equipo was successfully created.' }
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
        format.html { redirect_to @objeto, notice: 'Equipo was successfully updated.' }
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
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to equipos_url, notice: 'Equipo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipo
      @objeto = Equipo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipo_params
      params.require(:equipo).permit(:equipo, :sha1, :administrador_id)
    end
end
