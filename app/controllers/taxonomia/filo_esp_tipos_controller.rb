class FiloEspTiposController < ApplicationController
  before_action :set_filo_esp_tipo, only: [:show, :edit, :update, :destroy]

  # GET /filo_esp_tipos
  # GET /filo_esp_tipos.json
  def index
    @filo_esp_tipos = FiloEspTipo.all
  end

  # GET /filo_esp_tipos/1
  # GET /filo_esp_tipos/1.json
  def show
  end

  # GET /filo_esp_tipos/new
  def new
    @filo_esp_tipo = FiloEspTipo.new
  end

  # GET /filo_esp_tipos/1/edit
  def edit
  end

  # POST /filo_esp_tipos
  # POST /filo_esp_tipos.json
  def create
    @filo_esp_tipo = FiloEspTipo.new(filo_esp_tipo_params)

    respond_to do |format|
      if @filo_esp_tipo.save
        format.html { redirect_to @filo_esp_tipo, notice: 'Filo esp tipo was successfully created.' }
        format.json { render :show, status: :created, location: @filo_esp_tipo }
      else
        format.html { render :new }
        format.json { render json: @filo_esp_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_esp_tipos/1
  # PATCH/PUT /filo_esp_tipos/1.json
  def update
    respond_to do |format|
      if @filo_esp_tipo.update(filo_esp_tipo_params)
        format.html { redirect_to @filo_esp_tipo, notice: 'Filo esp tipo was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_esp_tipo }
      else
        format.html { render :edit }
        format.json { render json: @filo_esp_tipo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_esp_tipos/1
  # DELETE /filo_esp_tipos/1.json
  def destroy
    @filo_esp_tipo.destroy
    respond_to do |format|
      format.html { redirect_to filo_esp_tipos_url, notice: 'Filo esp tipo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_esp_tipo
      @filo_esp_tipo = FiloEspTipo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_esp_tipo_params
      params.require(:filo_esp_tipo).permit(:filo_especie_id, :filo_tipo_especie_id)
    end
end
