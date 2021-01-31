class ClasificacionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_clasificacion, only: [:show, :edit, :update, :destroy]

  # GET /clasificaciones
  # GET /clasificaciones.json
  def index
    @coleccion = Clasificacion.all
  end

  # GET /clasificaciones/1
  # GET /clasificaciones/1.json
  def show
  end

  # GET /clasificaciones/new
  def new
    @objeto = Clasificacion.new
  end

  # GET /clasificaciones/1/edit
  def edit
  end

  # POST /clasificaciones
  # POST /clasificaciones.json
  def create
    @objeto = Clasificacion.new(clasificacion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Clasificacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clasificaciones/1
  # PATCH/PUT /clasificaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(clasificacion_params)
        format.html { redirect_to @objeto, notice: 'Clasificacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clasificaciones/1
  # DELETE /clasificaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to clasificaciones_url, notice: 'Clasificacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clasificacion
      @objeto = Clasificacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clasificacion_params
      params.require(:clasificacion).permit(:carpeta_id, :publicacion_id)
    end
end
