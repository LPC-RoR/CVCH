class EspAreasController < ApplicationController
  before_action :set_esp_area, only: [:show, :edit, :update, :destroy]

  # GET /esp_areas
  # GET /esp_areas.json
  def index
    @esp_areas = EspArea.all
  end

  # GET /esp_areas/1
  # GET /esp_areas/1.json
  def show
  end

  # GET /esp_areas/new
  def new
    @esp_area = EspArea.new
  end

  # GET /esp_areas/1/edit
  def edit
  end

  # POST /esp_areas
  # POST /esp_areas.json
  def create
    @esp_area = EspArea.new(esp_area_params)

    respond_to do |format|
      if @esp_area.save
        format.html { redirect_to @esp_area, notice: 'Esp area was successfully created.' }
        format.json { render :show, status: :created, location: @esp_area }
      else
        format.html { render :new }
        format.json { render json: @esp_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /esp_areas/1
  # PATCH/PUT /esp_areas/1.json
  def update
    respond_to do |format|
      if @esp_area.update(esp_area_params)
        format.html { redirect_to @esp_area, notice: 'Esp area was successfully updated.' }
        format.json { render :show, status: :ok, location: @esp_area }
      else
        format.html { render :edit }
        format.json { render json: @esp_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /esp_areas/1
  # DELETE /esp_areas/1.json
  def destroy
    @esp_area.destroy
    respond_to do |format|
      format.html { redirect_to esp_areas_url, notice: 'Esp area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_esp_area
      @esp_area = EspArea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def esp_area_params
      params.require(:esp_area).permit(:especie_id, :area_id)
    end
end
