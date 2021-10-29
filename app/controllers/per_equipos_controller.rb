class PerEquiposController < ApplicationController
  before_action :set_per_equipo, only: [:show, :edit, :update, :destroy]

  # GET /per_equipos
  # GET /per_equipos.json
  def index
    @per_equipos = PerEquipo.all
  end

  # GET /per_equipos/1
  # GET /per_equipos/1.json
  def show
  end

  # GET /per_equipos/new
  def new
    @per_equipo = PerEquipo.new
  end

  # GET /per_equipos/1/edit
  def edit
  end

  # POST /per_equipos
  # POST /per_equipos.json
  def create
    @per_equipo = PerEquipo.new(per_equipo_params)

    respond_to do |format|
      if @per_equipo.save
        format.html { redirect_to @per_equipo, notice: 'Per equipo was successfully created.' }
        format.json { render :show, status: :created, location: @per_equipo }
      else
        format.html { render :new }
        format.json { render json: @per_equipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /per_equipos/1
  # PATCH/PUT /per_equipos/1.json
  def update
    respond_to do |format|
      if @per_equipo.update(per_equipo_params)
        format.html { redirect_to @per_equipo, notice: 'Per equipo was successfully updated.' }
        format.json { render :show, status: :ok, location: @per_equipo }
      else
        format.html { render :edit }
        format.json { render json: @per_equipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /per_equipos/1
  # DELETE /per_equipos/1.json
  def destroy
    @per_equipo.destroy
    respond_to do |format|
      format.html { redirect_to per_equipos_url, notice: 'Per equipo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_per_equipo
      @per_equipo = PerEquipo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def per_equipo_params
      params.require(:per_equipo).permit(:app_perfil_id, :equipo_id)
    end
end
