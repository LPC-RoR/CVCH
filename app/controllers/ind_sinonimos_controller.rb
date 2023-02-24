class IndSinonimosController < ApplicationController
  before_action :set_ind_sinonimo, only: [:show, :edit, :update, :destroy]

  # GET /ind_sinonimos
  # GET /ind_sinonimos.json
  def index
    @ind_sinonimos = IndSinonimo.all
  end

  # GET /ind_sinonimos/1
  # GET /ind_sinonimos/1.json
  def show
  end

  # GET /ind_sinonimos/new
  def new
    @ind_sinonimo = IndSinonimo.new
  end

  # GET /ind_sinonimos/1/edit
  def edit
  end

  # POST /ind_sinonimos
  # POST /ind_sinonimos.json
  def create
    @ind_sinonimo = IndSinonimo.new(ind_sinonimo_params)

    respond_to do |format|
      if @ind_sinonimo.save
        format.html { redirect_to @ind_sinonimo, notice: 'Ind sinonimo was successfully created.' }
        format.json { render :show, status: :created, location: @ind_sinonimo }
      else
        format.html { render :new }
        format.json { render json: @ind_sinonimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_sinonimos/1
  # PATCH/PUT /ind_sinonimos/1.json
  def update
    respond_to do |format|
      if @ind_sinonimo.update(ind_sinonimo_params)
        format.html { redirect_to @ind_sinonimo, notice: 'Ind sinonimo was successfully updated.' }
        format.json { render :show, status: :ok, location: @ind_sinonimo }
      else
        format.html { render :edit }
        format.json { render json: @ind_sinonimo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_sinonimos/1
  # DELETE /ind_sinonimos/1.json
  def destroy
    @ind_sinonimo.destroy
    respond_to do |format|
      format.html { redirect_to ind_sinonimos_url, notice: 'Ind sinonimo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_sinonimo
      @ind_sinonimo = IndSinonimo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_sinonimo_params
      params.require(:ind_sinonimo).permit(:ind_sinonimo)
    end
end
