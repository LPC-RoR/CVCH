class CarFiloEspsController < ApplicationController
  before_action :set_car_filo_esp, only: [:show, :edit, :update, :destroy]

  # GET /car_filo_esps
  # GET /car_filo_esps.json
  def index
    @car_filo_esps = CarFiloEsp.all
  end

  # GET /car_filo_esps/1
  # GET /car_filo_esps/1.json
  def show
  end

  # GET /car_filo_esps/new
  def new
    @car_filo_esp = CarFiloEsp.new
  end

  # GET /car_filo_esps/1/edit
  def edit
  end

  # POST /car_filo_esps
  # POST /car_filo_esps.json
  def create
    @car_filo_esp = CarFiloEsp.new(car_filo_esp_params)

    respond_to do |format|
      if @car_filo_esp.save
        format.html { redirect_to @car_filo_esp, notice: 'Car filo esp was successfully created.' }
        format.json { render :show, status: :created, location: @car_filo_esp }
      else
        format.html { render :new }
        format.json { render json: @car_filo_esp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /car_filo_esps/1
  # PATCH/PUT /car_filo_esps/1.json
  def update
    respond_to do |format|
      if @car_filo_esp.update(car_filo_esp_params)
        format.html { redirect_to @car_filo_esp, notice: 'Car filo esp was successfully updated.' }
        format.json { render :show, status: :ok, location: @car_filo_esp }
      else
        format.html { render :edit }
        format.json { render json: @car_filo_esp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /car_filo_esps/1
  # DELETE /car_filo_esps/1.json
  def destroy
    @car_filo_esp.destroy
    respond_to do |format|
      format.html { redirect_to car_filo_esps_url, notice: 'Car filo esp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car_filo_esp
      @car_filo_esp = CarFiloEsp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_filo_esp_params
      params.require(:car_filo_esp).permit(:carpeta_id, :filo_especie)
    end
end
