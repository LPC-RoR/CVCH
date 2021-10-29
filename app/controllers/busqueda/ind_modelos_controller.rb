class Busqueda::IndModelosController < ApplicationController
  before_action :inicia_sesion
  before_action :set_ind_modelo, only: [:show, :edit, :update, :destroy]

  # GET /ind_modelos
  # GET /ind_modelos.json
  def index
    @coleccion = IndModelo.all
  end

  # GET /ind_modelos/1
  # GET /ind_modelos/1.json
  def show
  end

  # GET /ind_modelos/new
  def new
    @objeto = IndModelo.new(ind_estructura_id: params[:ind_estructura_id])
  end

  # GET /ind_modelos/1/edit
  def edit
  end

  # POST /ind_modelos
  # POST /ind_modelos.json
  def create
    @objeto = IndModelo.new(ind_modelo_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind modelo was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_modelos/1
  # PATCH/PUT /ind_modelos/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_modelo_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind modelo was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_modelos/1
  # DELETE /ind_modelos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Ind modelo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_modelo
      @objeto = IndModelo.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.ind_estructura
    end

    # Only allow a list of trusted parameters through.
    def ind_modelo_params
      params.require(:ind_modelo).permit(:ind_modelo, :campos, :ind_estructura_id)
    end
end
