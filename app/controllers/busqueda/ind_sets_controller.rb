class Busqueda::IndSetsController < ApplicationController
  before_action :set_ind_set, only: [:show, :edit, :update, :destroy]

  # GET /ind_sets
  # GET /ind_sets.json
  def index
    @coleccion = IndSet.all
  end

  # GET /ind_sets/1
  # GET /ind_sets/1.json
  def show
  end

  # GET /ind_sets/new
  def new
    @objeto = IndSet.new
  end

  # GET /ind_sets/1/edit
  def edit
  end

  # POST /ind_sets
  # POST /ind_sets.json
  def create
    @objeto = IndSet.new(ind_set_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind set was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_sets/1
  # PATCH/PUT /ind_sets/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_set_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind set was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_sets/1
  # DELETE /ind_sets/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Ind set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_set
      @objeto = IndSet.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/ind_estructuras"
    end

    # Only allow a list of trusted parameters through.
    def ind_set_params
      params.require(:ind_set).permit(:ind_set, :tipo, :set)
    end
end
