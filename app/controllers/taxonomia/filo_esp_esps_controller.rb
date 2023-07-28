class FiloEspEspsController < ApplicationController
  before_action :set_filo_esp_esp, only: [:show, :edit, :update, :destroy]

  # GET /filo_esp_esps
  # GET /filo_esp_esps.json
  def index
    @filo_esp_esps = FiloEspEsp.all
  end

  # GET /filo_esp_esps/1
  # GET /filo_esp_esps/1.json
  def show
  end

  # GET /filo_esp_esps/new
  def new
    @filo_esp_esp = FiloEspEsp.new
  end

  # GET /filo_esp_esps/1/edit
  def edit
  end

  # POST /filo_esp_esps
  # POST /filo_esp_esps.json
  def create
    @filo_esp_esp = FiloEspEsp.new(filo_esp_esp_params)

    respond_to do |format|
      if @filo_esp_esp.save
        format.html { redirect_to @filo_esp_esp, notice: 'Filo esp esp was successfully created.' }
        format.json { render :show, status: :created, location: @filo_esp_esp }
      else
        format.html { render :new }
        format.json { render json: @filo_esp_esp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_esp_esps/1
  # PATCH/PUT /filo_esp_esps/1.json
  def update
    respond_to do |format|
      if @filo_esp_esp.update(filo_esp_esp_params)
        format.html { redirect_to @filo_esp_esp, notice: 'Filo esp esp was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_esp_esp }
      else
        format.html { render :edit }
        format.json { render json: @filo_esp_esp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_esp_esps/1
  # DELETE /filo_esp_esps/1.json
  def destroy
    @filo_esp_esp.destroy
    respond_to do |format|
      format.html { redirect_to filo_esp_esps_url, notice: 'Filo esp esp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_esp_esp
      @filo_esp_esp = FiloEspEsp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_esp_esp_params
      params.require(:filo_esp_esp).permit(:parent_id, :child_id)
    end
end
