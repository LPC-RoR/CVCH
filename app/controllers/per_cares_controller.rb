class PerCaresController < ApplicationController
  before_action :set_per_car, only: [:show, :edit, :update, :destroy]

  # GET /per_cares
  # GET /per_cares.json
  def index
    @per_cares = PerCar.all
  end

  # GET /per_cares/1
  # GET /per_cares/1.json
  def show
  end

  # GET /per_cares/new
  def new
    @per_car = PerCar.new
  end

  # GET /per_cares/1/edit
  def edit
  end

  # POST /per_cares
  # POST /per_cares.json
  def create
    @per_car = PerCar.new(per_car_params)

    respond_to do |format|
      if @per_car.save
        format.html { redirect_to @per_car, notice: 'Per car was successfully created.' }
        format.json { render :show, status: :created, location: @per_car }
      else
        format.html { render :new }
        format.json { render json: @per_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /per_cares/1
  # PATCH/PUT /per_cares/1.json
  def update
    respond_to do |format|
      if @per_car.update(per_car_params)
        format.html { redirect_to @per_car, notice: 'Per car was successfully updated.' }
        format.json { render :show, status: :ok, location: @per_car }
      else
        format.html { render :edit }
        format.json { render json: @per_car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /per_cares/1
  # DELETE /per_cares/1.json
  def destroy
    @per_car.destroy
    respond_to do |format|
      format.html { redirect_to per_cares_url, notice: 'Per car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_per_car
      @per_car = PerCar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def per_car_params
      params.require(:per_car).permit(:app_perfil_id, :carpeta_id)
    end
end
