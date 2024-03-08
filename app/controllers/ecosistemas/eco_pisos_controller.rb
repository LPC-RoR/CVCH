class Ecosistemas::EcoPisosController < ApplicationController
  before_action :set_eco_piso, only: [:show, :edit, :update, :destroy]

  # GET /eco_pisos
  # GET /eco_pisos.json
  def index
    @coleccion = EcoPiso.all
  end

  # GET /eco_pisos/1
  # GET /eco_pisos/1.json
  def show
  end

  # GET /eco_pisos/new
  def new
    @objeto = EcoPiso.new(eco_formacion_id: params[:fid])
  end

  # GET /eco_pisos/1/edit
  def edit
  end

  # POST /eco_pisos
  # POST /eco_pisos.json
  def create
    @objeto = EcoPiso.new(eco_piso_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eco_pisos/1
  # PATCH/PUT /eco_pisos/1.json
  def update
    respond_to do |format|
      if @objeto.update(eco_piso_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente actualizado.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eco_pisos/1
  # DELETE /eco_pisos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eco_piso
      @objeto = EcoPiso.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'formaciones_pisos')}"
    end

    # Only allow a list of trusted parameters through.
    def eco_piso_params
      params.require(:eco_piso).permit(:eco_formacion_id, :eco_piso)
    end
end
