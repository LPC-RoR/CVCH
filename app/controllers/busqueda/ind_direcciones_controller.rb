class Busqueda::IndDireccionesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_ind_direccion, only: [:show, :edit, :update, :destroy]

  # GET /ind_direcciones
  # GET /ind_direcciones.json
  def index
    @coleccion = IndDireccion.all
  end

  # GET /ind_direcciones/1
  # GET /ind_direcciones/1.json
  def show
  end

  # GET /ind_direcciones/new
  def new
    @objeto = IndDireccion.new
  end

  # GET /ind_direcciones/1/edit
  def edit
  end

  # POST /ind_direcciones
  # POST /ind_direcciones.json
  def create
    @objeto = IndDireccion.new(ind_direccion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind direccion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_direcciones/1
  # PATCH/PUT /ind_direcciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_direccion_params)
        format.html { redirect_to @objeto, notice: 'Ind direccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_direcciones/1
  # DELETE /ind_direcciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_direcciones_url, notice: 'Ind direccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_direccion
      @objeto = IndDireccion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_direccion_params
      params.require(:ind_direccion).permit(:origen_id, :destino_id)
    end
end
