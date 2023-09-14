class Taxonomia::FiloFuentesController < ApplicationController
  before_action :set_filo_fuente, only: [:show, :edit, :update, :destroy]
  before_action :carga_solo_sidebar, only: %i[ show new edit create update ]

  include Sidebar

  # GET /filo_fuentes
  # GET /filo_fuentes.json
  def index
    @coleccion = FiloFuente.all
  end

  # GET /filo_fuentes/1
  # GET /filo_fuentes/1.json
  def show
  end

  # GET /filo_fuentes/new
  def new
    @objeto = FiloFuente.new
  end

  # GET /filo_fuentes/1/edit
  def edit
  end

  # POST /filo_fuentes
  # POST /filo_fuentes.json
  def create
    @objeto = FiloFuente.new(filo_fuente_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Fuente fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_fuentes/1
  # PATCH/PUT /filo_fuentes/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_fuente_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Fuente fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_fuentes/1
  # DELETE /filo_fuentes/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Fuente fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_fuente
      @objeto = FiloFuente.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/app_recursos/administracion?id=#{get_elemento_id(controller_name, 'Fuentes de Información')}" 
    end

    # Only allow a list of trusted parameters through.
    def filo_fuente_params
      params.require(:filo_fuente).permit(:filo_fuente)
    end
end
