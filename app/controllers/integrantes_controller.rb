class IntegrantesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_integrante, only: [:show, :edit, :update, :destroy]

  # GET /integrantes
  # GET /integrantes.json
  def index
    @coleccion = Integrante.all
  end

  # GET /integrantes/1
  # GET /integrantes/1.json
  def show
  end

  # GET /integrantes/new
  def new
    @objeto = Integrante.new
  end

  # GET /integrantes/1/edit
  def edit
  end

  # POST /integrantes
  # POST /integrantes.json
  def create
    @objeto = Integrante.new(integrante_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Integrante was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /integrantes/1
  # PATCH/PUT /integrantes/1.json
  def update
    respond_to do |format|
      if @objeto.update(integrante_params)
        format.html { redirect_to @objeto, notice: 'Integrante was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /integrantes/1
  # DELETE /integrantes/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to integrantes_url, notice: 'Integrante was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_integrante
      @objeto = Integrante.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def integrante_params
      params.require(:integrante).permit(:investigador_id, :equipo_id)
    end
end
