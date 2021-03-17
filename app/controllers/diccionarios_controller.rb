class DiccionariosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_diccionario, only: [:show, :edit, :update, :destroy]

  # GET /diccionarios
  # GET /diccionarios.json
  def index
    @coleccion = Diccionario.all
  end

  # GET /diccionarios/1
  # GET /diccionarios/1.json
  def show
  end

  # GET /diccionarios/new
  def new
    @objeto = Diccionario.new
  end

  # GET /diccionarios/1/edit
  def edit
  end

  # POST /diccionarios
  # POST /diccionarios.json
  def create
    @objeto = Diccionario.new(diccionario_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Diccionario was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diccionarios/1
  # PATCH/PUT /diccionarios/1.json
  def update
    respond_to do |format|
      if @objeto.update(diccionario_params)
        format.html { redirect_to @objeto, notice: 'Diccionario was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diccionarios/1
  # DELETE /diccionarios/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to diccionarios_url, notice: 'Diccionario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diccionario
      @objeto = Diccionario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diccionario_params
      params.require(:diccionario).permit(:concepto_id, :instancia_id)
    end
end
