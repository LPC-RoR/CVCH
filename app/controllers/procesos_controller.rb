class ProcesosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_proceso, only: [:show, :edit, :update, :destroy]

  # GET /procesos
  # GET /procesos.json
  def index
    @coleccion = Proceso.all
  end

  # GET /procesos/1
  # GET /procesos/1.json
  def show
  end

  # GET /procesos/new
  def new
    @objeto = Proceso.new
  end

  # GET /procesos/1/edit
  def edit
  end

  # POST /procesos
  # POST /procesos.json
  def create
    @objeto = Proceso.new(proceso_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Proceso was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procesos/1
  # PATCH/PUT /procesos/1.json
  def update
    respond_to do |format|
      if @objeto.update(proceso_params)
        format.html { redirect_to @objeto, notice: 'Proceso was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procesos/1
  # DELETE /procesos/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to procesos_url, notice: 'Proceso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proceso
      @objeto = Proceso.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proceso_params
      params.require(:proceso).permit(:carga_id, :publicacion_id)
    end
end
