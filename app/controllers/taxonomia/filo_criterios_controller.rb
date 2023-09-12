class Taxonomia::FiloCriteriosController < ApplicationController
  before_action :set_filo_criterio, only: [:show, :edit, :update, :destroy]

  # GET /filo_criterios
  # GET /filo_criterios.json
  def index
    @filo_criterios = FiloCriterio.all
  end

  # GET /filo_criterios/1
  # GET /filo_criterios/1.json
  def show
  end

  # GET /filo_criterios/new
  def new
    @filo_criterio = FiloCriterio.new
  end

  # GET /filo_criterios/1/edit
  def edit
  end

  # POST /filo_criterios
  # POST /filo_criterios.json
  def create
    @filo_criterio = FiloCriterio.new(filo_criterio_params)

    respond_to do |format|
      if @filo_criterio.save
        format.html { redirect_to @filo_criterio, notice: 'Filo criterio was successfully created.' }
        format.json { render :show, status: :created, location: @filo_criterio }
      else
        format.html { render :new }
        format.json { render json: @filo_criterio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_criterios/1
  # PATCH/PUT /filo_criterios/1.json
  def update
    respond_to do |format|
      if @filo_criterio.update(filo_criterio_params)
        format.html { redirect_to @filo_criterio, notice: 'Filo criterio was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_criterio }
      else
        format.html { render :edit }
        format.json { render json: @filo_criterio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_criterios/1
  # DELETE /filo_criterios/1.json
  def destroy
    @filo_criterio.destroy
    respond_to do |format|
      format.html { redirect_to filo_criterios_url, notice: 'Filo criterio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_criterio
      @filo_criterio = FiloCriterio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_criterio_params
      params.require(:filo_criterio).permit(:filo_conflicto_id, :problema, :criterio, :fuente, :link_fuente)
    end
end
