class Taxonomia::FiloActualizacionesController < ApplicationController
  before_action :set_filo_actualizacion, only: [:show, :edit, :update, :destroy]

  # GET /filo_actualizaciones
  # GET /filo_actualizaciones.json
  def index
    @coleccion = FiloActualizacion.all
  end

  # GET /filo_actualizaciones/1
  # GET /filo_actualizaciones/1.json
  def show
  end

  # GET /filo_actualizaciones/new
  def new
    @objeto = FiloActualizacion.new(filo_especie_id: params[:indice])
  end

  # GET /filo_actualizaciones/1/edit
  def edit
  end

  # POST /filo_actualizaciones
  # POST /filo_actualizaciones.json
  def create
    @objeto = FiloActualizacion.new(filo_actualizacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Actualización fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_actualizaciones/1
  # PATCH/PUT /filo_actualizaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_actualizacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Actualización fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_actualizaciones/1
  # DELETE /filo_actualizaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Actualización fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_actualizacion
      @objeto = FiloActualizacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/publicos/especies?indice=#{@objeto.filo_especie.id}"
    end

    # Only allow a list of trusted parameters through.
    def filo_actualizacion_params
      params.require(:filo_actualizacion).permit(:app_perfil_id, :filo_fuente_id, :referencia, :nombre_comun, :link_fuentesinonimia, :filo_especie_id, :link_fuente, :sinonimia)
    end
end
