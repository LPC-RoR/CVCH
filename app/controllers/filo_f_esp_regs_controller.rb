class FiloFEspRegsController < ApplicationController
  before_action :set_filo_f_esp_reg, only: [:show, :edit, :update, :destroy]

  # GET /filo_f_esp_regs
  # GET /filo_f_esp_regs.json
  def index
    @filo_f_esp_regs = FiloFEspReg.all
  end

  # GET /filo_f_esp_regs/1
  # GET /filo_f_esp_regs/1.json
  def show
  end

  # GET /filo_f_esp_regs/new
  def new
    @filo_f_esp_reg = FiloFEspReg.new
  end

  # GET /filo_f_esp_regs/1/edit
  def edit
  end

  # POST /filo_f_esp_regs
  # POST /filo_f_esp_regs.json
  def create
    @filo_f_esp_reg = FiloFEspReg.new(filo_f_esp_reg_params)

    respond_to do |format|
      if @filo_f_esp_reg.save
        format.html { redirect_to @filo_f_esp_reg, notice: 'Filo f esp reg was successfully created.' }
        format.json { render :show, status: :created, location: @filo_f_esp_reg }
      else
        format.html { render :new }
        format.json { render json: @filo_f_esp_reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_f_esp_regs/1
  # PATCH/PUT /filo_f_esp_regs/1.json
  def update
    respond_to do |format|
      if @filo_f_esp_reg.update(filo_f_esp_reg_params)
        format.html { redirect_to @filo_f_esp_reg, notice: 'Filo f esp reg was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_f_esp_reg }
      else
        format.html { render :edit }
        format.json { render json: @filo_f_esp_reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_f_esp_regs/1
  # DELETE /filo_f_esp_regs/1.json
  def destroy
    @filo_f_esp_reg.destroy
    respond_to do |format|
      format.html { redirect_to filo_f_esp_regs_url, notice: 'Filo f esp reg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_f_esp_reg
      @filo_f_esp_reg = FiloFEspReg.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_f_esp_reg_params
      params.require(:filo_f_esp_reg).permit(:filo_especie_id, :region_id)
    end
end
