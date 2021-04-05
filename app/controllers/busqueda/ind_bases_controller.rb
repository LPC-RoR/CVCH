class Busqueda::IndBasesController < ApplicationController
  before_action :set_ind_base, only: [:show, :edit, :update, :destroy]

  # GET /ind_bases
  # GET /ind_bases.json
  def index
    @coleccion = IndBase.all
  end

  # GET /ind_bases/1
  # GET /ind_bases/1.json
  def show
  end

  # GET /ind_bases/new
  def new
    @objeto = IndBase.new
  end

  # GET /ind_bases/1/edit
  def edit
  end

  # POST /ind_bases
  # POST /ind_bases.json
  def create
    @objeto = IndBase.new(ind_base_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind base was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_bases/1
  # PATCH/PUT /ind_bases/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_base_params)
        format.html { redirect_to @objeto, notice: 'Ind base was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_bases/1
  # DELETE /ind_bases/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_bases_url, notice: 'Ind base was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_base
      @objeto = IndBase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_base_params
      params.require(:ind_base).permit(:clave_id, :ind_palabra_id)
    end
end
