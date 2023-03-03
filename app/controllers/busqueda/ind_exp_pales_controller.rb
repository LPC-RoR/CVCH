class Busqueda::IndExpPalesController < ApplicationController
  before_action :set_ind_exp_pal, only: [:show, :edit, :update, :destroy]

  # GET /ind_exp_pales
  # GET /ind_exp_pales.json
  def index
    @coleccion = IndExpPal.all
  end

  # GET /ind_exp_pales/1
  # GET /ind_exp_pales/1.json
  def show
  end

  # GET /ind_exp_pales/new
  def new
    @objeto = IndExpPal.new
  end

  # GET /ind_exp_pales/1/edit
  def edit
  end

  # POST /ind_exp_pales
  # POST /ind_exp_pales.json
  def create
    @objeto = IndExpPal.new(ind_exp_pal_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind exp pal was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_exp_pales/1
  # PATCH/PUT /ind_exp_pales/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_exp_pal_params)
        format.html { redirect_to @objeto, notice: 'Ind exp pal was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_exp_pales/1
  # DELETE /ind_exp_pales/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_exp_pales_url, notice: 'Ind exp pal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_exp_pal
      @objeto = IndExpPal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_exp_pal_params
      params.require(:ind_exp_pal).permit(:ind_expresion_id, :ind_palabra_id)
    end
end
