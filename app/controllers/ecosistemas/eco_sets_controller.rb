class Ecosistemas::EcoSetsController < ApplicationController
  before_action :set_eco_set, only: [:show, :edit, :update, :destroy]

  # GET /eco_sets
  # GET /eco_sets.json
  def index
    @coleccion = EcoSet.all
  end

  # GET /eco_sets/1
  # GET /eco_sets/1.json
  def show
  end

  # GET /eco_sets/new
  def new
    @objeto = EcoSet.new(publicacion_id: params[:pid])
  end

  # GET /eco_sets/1/edit
  def edit
  end

  # POST /eco_sets
  # POST /eco_sets.json
  def create
    @objeto = EcoSet.new(eco_set_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Set de datos fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eco_sets/1
  # PATCH/PUT /eco_sets/1.json
  def update
    respond_to do |format|
      if @objeto.update(eco_set_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Set de datos fue exitósamente actualizado.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eco_sets/1
  # DELETE /eco_sets/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Set de datos fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eco_set
      @objeto = EcoSet.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.publicacion
    end

    # Only allow a list of trusted parameters through.
    def eco_set_params
      params.require(:eco_set).permit(:eco_lugar_id, :publicacion_id, :annio, :coordenadas, :fecha)
    end
end
