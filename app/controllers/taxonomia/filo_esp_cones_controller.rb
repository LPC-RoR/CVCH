class FiloEspConesController < ApplicationController
  before_action :set_filo_esp_con, only: [:show, :edit, :update, :destroy]

  # GET /filo_esp_cones
  # GET /filo_esp_cones.json
  def index
    @filo_esp_cones = FiloEspCon.all
  end

  # GET /filo_esp_cones/1
  # GET /filo_esp_cones/1.json
  def show
  end

  # GET /filo_esp_cones/new
  def new
    @filo_esp_con = FiloEspCon.new
  end

  # GET /filo_esp_cones/1/edit
  def edit
  end

  # POST /filo_esp_cones
  # POST /filo_esp_cones.json
  def create
    @filo_esp_con = FiloEspCon.new(filo_esp_con_params)

    respond_to do |format|
      if @filo_esp_con.save
        format.html { redirect_to @filo_esp_con, notice: 'Filo esp con was successfully created.' }
        format.json { render :show, status: :created, location: @filo_esp_con }
      else
        format.html { render :new }
        format.json { render json: @filo_esp_con.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_esp_cones/1
  # PATCH/PUT /filo_esp_cones/1.json
  def update
    respond_to do |format|
      if @filo_esp_con.update(filo_esp_con_params)
        format.html { redirect_to @filo_esp_con, notice: 'Filo esp con was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_esp_con }
      else
        format.html { render :edit }
        format.json { render json: @filo_esp_con.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_esp_cones/1
  # DELETE /filo_esp_cones/1.json
  def destroy
    @filo_esp_con.destroy
    respond_to do |format|
      format.html { redirect_to filo_esp_cones_url, notice: 'Filo esp con was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_esp_con
      @filo_esp_con = FiloEspCon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_esp_con_params
      params.require(:filo_esp_con).permit(:filo_especie_id, :filo_categoria_conservacion_id)
    end
end
