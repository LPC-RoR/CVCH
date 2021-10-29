class Busqueda::IndRedaccionesController < ApplicationController
  before_action :inicia_sesion
  before_action :set_ind_redaccion, only: [:show, :edit, :update, :destroy]

  # GET /ind_redacciones
  # GET /ind_redacciones.json
  def index
    @coleccion = IndRedaccion.all
  end

  # GET /ind_redacciones/1
  # GET /ind_redacciones/1.json
  def show
  end

  # GET /ind_redacciones/new
  def new
    @objeto = IndRedaccion.new
  end

  # GET /ind_redacciones/1/edit
  def edit
  end

  # POST /ind_redacciones
  # POST /ind_redacciones.json
  def create
    @objeto = IndRedaccion.new(ind_redaccion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind redaccion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_redacciones/1
  # PATCH/PUT /ind_redacciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_redaccion_params)
        format.html { redirect_to @objeto, notice: 'Ind redaccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_redacciones/1
  # DELETE /ind_redacciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_redacciones_url, notice: 'Ind redaccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_redaccion
      @objeto = IndRedaccion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_redaccion_params
      params.require(:ind_redaccion).permit(:ind_palabra_id, :ind_expresion_id)
    end
end
