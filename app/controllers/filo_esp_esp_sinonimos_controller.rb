class FiloEspEspSinonimosController < ApplicationController
  before_action :set_filo_esp_esp_sinonimo, only: [:show, :edit, :update, :destroy]

  # GET /filo_esp_esp_sinonimos
  # GET /filo_esp_esp_sinonimos.json
  def index
    @filo_esp_esp_sinonimos = FiloEspEspSinonimo.all
  end

  # GET /filo_esp_esp_sinonimos/1
  # GET /filo_esp_esp_sinonimos/1.json
  def show
  end

  # GET /filo_esp_esp_sinonimos/new
  def new
    @filo_esp_esp_sinonimo = FiloEspEspSinonimo.new
  end

  # GET /filo_esp_esp_sinonimos/1/edit
  def edit
  end

  # POST /filo_esp_esp_sinonimos
  # POST /filo_esp_esp_sinonimos.json
  def create
    @filo_esp_esp_sinonimo = FiloEspEspSinonimo.new(filo_esp_esp_sinonimo_params)

    respond_to do |format|
      if @filo_esp_esp_sinonimo.save
        format.html { redirect_to @filo_esp_esp_sinonimo, notice: 'Filo esp esp sinonimo was successfully created.' }
        format.json { render :show, status: :created, location: @filo_esp_esp_sinonimo }
      else
        format.html { render :new }
        format.json { render json: @filo_esp_esp_sinonimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_esp_esp_sinonimos/1
  # PATCH/PUT /filo_esp_esp_sinonimos/1.json
  def update
    respond_to do |format|
      if @filo_esp_esp_sinonimo.update(filo_esp_esp_sinonimo_params)
        format.html { redirect_to @filo_esp_esp_sinonimo, notice: 'Filo esp esp sinonimo was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_esp_esp_sinonimo }
      else
        format.html { render :edit }
        format.json { render json: @filo_esp_esp_sinonimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_esp_esp_sinonimos/1
  # DELETE /filo_esp_esp_sinonimos/1.json
  def destroy
    @filo_esp_esp_sinonimo.destroy
    respond_to do |format|
      format.html { redirect_to filo_esp_esp_sinonimos_url, notice: 'Filo esp esp sinonimo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_esp_esp_sinonimo
      @filo_esp_esp_sinonimo = FiloEspEspSinonimo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_esp_esp_sinonimo_params
      params.require(:filo_esp_esp_sinonimo).permit(:especie_id, :sinonimo_id)
    end
end
