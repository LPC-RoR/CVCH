class SuscripcionesController < ApplicationController
  before_action :set_suscripcion, only: [:show, :edit, :update, :destroy]

  # GET /suscripciones
  # GET /suscripciones.json
  def index
    @coleccion = Suscripcion.all
  end

  # GET /suscripciones/1
  # GET /suscripciones/1.json
  def show
  end

  # GET /suscripciones/new
  def new
    @objeto = Suscripcion.new
  end

  # GET /suscripciones/1/edit
  def edit
  end

  # POST /suscripciones
  # POST /suscripciones.json
  def create
    @objeto = Suscripcion.new(suscripcion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Suscripcion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suscripciones/1
  # PATCH/PUT /suscripciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(suscripcion_params)
        format.html { redirect_to @objeto, notice: 'Suscripcion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suscripciones/1
  # DELETE /suscripciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to suscripciones_url, notice: 'Suscripcion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_suscripcion
      @objeto = Suscripcion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def suscripcion_params
      params.require(:suscripcion).permit(:categoria_id, :perfil_id)
    end
end
