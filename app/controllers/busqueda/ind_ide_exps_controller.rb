class Busqueda::IndIdeExpsController < ApplicationController
  before_action :set_ind_ide_exp, only: [:show, :edit, :update, :destroy]

  # GET /ind_ide_exps
  # GET /ind_ide_exps.json
  def index
    @coleccion = IndIdeExp.all
  end

  # GET /ind_ide_exps/1
  # GET /ind_ide_exps/1.json
  def show
  end

  # GET /ind_ide_exps/new
  def new
    @objeto = IndIdeExp.new
  end

  # GET /ind_ide_exps/1/edit
  def edit
  end

  # POST /ind_ide_exps
  # POST /ind_ide_exps.json
  def create
    @objeto = IndIdeExp.new(ind_ide_exp_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind ide exp was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_ide_exps/1
  # PATCH/PUT /ind_ide_exps/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_ide_exp_params)
        format.html { redirect_to @objeto, notice: 'Ind ide exp was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_ide_exps/1
  # DELETE /ind_ide_exps/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_ide_exps_url, notice: 'Ind ide exp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_ide_exp
      @objeto = IndIdeExp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_ide_exp_params
      params.require(:ind_ide_exp).permit(:ind_idea_id, :ind_expresion_id)
    end
end
