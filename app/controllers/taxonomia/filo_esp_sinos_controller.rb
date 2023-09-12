class FiloEspSinosController < ApplicationController
  before_action :set_filo_esp_sino, only: [:show, :edit, :update, :destroy]

  # GET /filo_esp_sinos
  # GET /filo_esp_sinos.json
  def index
    @filo_esp_sinos = FiloEspSino.all
  end

  # GET /filo_esp_sinos/1
  # GET /filo_esp_sinos/1.json
  def show
  end

  # GET /filo_esp_sinos/new
  def new
    @filo_esp_sino = FiloEspSino.new
  end

  # GET /filo_esp_sinos/1/edit
  def edit
  end

  # POST /filo_esp_sinos
  # POST /filo_esp_sinos.json
  def create
    @filo_esp_sino = FiloEspSino.new(filo_esp_sino_params)

    respond_to do |format|
      if @filo_esp_sino.save
        format.html { redirect_to @filo_esp_sino, notice: 'Filo esp sino was successfully created.' }
        format.json { render :show, status: :created, location: @filo_esp_sino }
      else
        format.html { render :new }
        format.json { render json: @filo_esp_sino.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_esp_sinos/1
  # PATCH/PUT /filo_esp_sinos/1.json
  def update
    respond_to do |format|
      if @filo_esp_sino.update(filo_esp_sino_params)
        format.html { redirect_to @filo_esp_sino, notice: 'Filo esp sino was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_esp_sino }
      else
        format.html { render :edit }
        format.json { render json: @filo_esp_sino.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_esp_sinos/1
  # DELETE /filo_esp_sinos/1.json
  def destroy
    @filo_esp_sino.destroy
    respond_to do |format|
      format.html { redirect_to filo_esp_sinos_url, notice: 'Filo esp sino was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_esp_sino
      @filo_esp_sino = FiloEspSino.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_esp_sino_params
      params.require(:filo_esp_sino).permit(:filo_especie_id, :filo_sinonimo_id)
    end
end
