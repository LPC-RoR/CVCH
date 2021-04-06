class Busqueda::IndLenguajesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_ind_lenguaje, only: [:show, :edit, :update, :destroy]

  # GET /ind_lenguajes
  # GET /ind_lenguajes.json
  def index
    @coleccion = IndLenguaje.all
  end

  # GET /ind_lenguajes/1
  # GET /ind_lenguajes/1.json
  def show
  end

  # GET /ind_lenguajes/new
  def new
    @objeto = IndLenguaje.new
  end

  # GET /ind_lenguajes/1/edit
  def edit
  end

  # POST /ind_lenguajes
  # POST /ind_lenguajes.json
  def create
    @objeto = IndLenguaje.new(ind_lenguaje_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind lenguaje was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_lenguajes/1
  # PATCH/PUT /ind_lenguajes/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_lenguaje_params)
        format.html { redirect_to @objeto, notice: 'Ind lenguaje was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_lenguajes/1
  # DELETE /ind_lenguajes/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_lenguajes_url, notice: 'Ind lenguaje was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_lenguaje
      @objeto = IndLenguaje.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_lenguaje_params
      params.require(:ind_lenguaje).permit(:ind_lenguaje)
    end
end
