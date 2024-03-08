class Ecosistemas::EcoLugaresController < ApplicationController
  before_action :set_eco_lugar, only: [:show, :edit, :update, :destroy]

  # GET /eco_lugares
  # GET /eco_lugares.json
  def index
    @coleccion = EcoLugar.all
  end

  # GET /eco_lugares/1
  # GET /eco_lugares/1.json
  def show
  end

  # GET /eco_lugares/new
  def new
    @objeto = EcoLugar.new
  end

  # GET /eco_lugares/1/edit
  def edit
  end

  # POST /eco_lugares
  # POST /eco_lugares.json
  def create
    @objeto = EcoLugar.new(eco_lugar_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Eco lugar was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eco_lugares/1
  # PATCH/PUT /eco_lugares/1.json
  def update
    respond_to do |format|
      if @objeto.update(eco_lugar_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Eco lugar was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eco_lugares/1
  # DELETE /eco_lugares/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Eco lugar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_eco_lugar
      @objeto = EcoLugar.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'regiones_lugares')}"
    end

    # Only allow a list of trusted parameters through.
    def eco_lugar_params
      params.require(:eco_lugar).permit(:eco_lugar, :region_id, :coordenadas, :eco_piso_id)
    end
end
