class Ecosistemas::EcoFormacionesController < ApplicationController
  before_action :set_eco_formacion, only: [:show, :edit, :update, :destroy]

  # GET /eco_formaciones
  # GET /eco_formaciones.json
  def index
    @coleccion = EcoFormacion.all
  end

  # GET /eco_formaciones/1
  # GET /eco_formaciones/1.json
  def show
  end

  # GET /eco_formaciones/new
  def new
    @objeto = EcoFormacion.new
  end

  # GET /eco_formaciones/1/edit
  def edit
  end

  # POST /eco_formaciones
  # POST /eco_formaciones.json
  def create
    @objeto = EcoFormacion.new(eco_formacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Formacion fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eco_formaciones/1
  # PATCH/PUT /eco_formaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(eco_formacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Formacion fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eco_formaciones/1
  # DELETE /eco_formaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Formacion fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eco_formacion
      @objeto = EcoFormacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'formaciones_pisos')}"
    end

    # Only allow a list of trusted parameters through.
    def eco_formacion_params
      params.require(:eco_formacion).permit(:eco_formacion)
    end
end
