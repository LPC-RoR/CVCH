class AscendenciasController < ApplicationController
  before_action :set_ascendencia, only: [:show, :edit, :update, :destroy]

  # GET /ascendencias
  # GET /ascendencias.json
  def index
    @ascendencias = Ascendencia.all
  end

  # GET /ascendencias/1
  # GET /ascendencias/1.json
  def show
  end

  # GET /ascendencias/new
  def new
    @ascendencia = Ascendencia.new
  end

  # GET /ascendencias/1/edit
  def edit
  end

  # POST /ascendencias
  # POST /ascendencias.json
  def create
    @ascendencia = Ascendencia.new(ascendencia_params)

    respond_to do |format|
      if @ascendencia.save
        format.html { redirect_to @ascendencia, notice: 'Ascendencia was successfully created.' }
        format.json { render :show, status: :created, location: @ascendencia }
      else
        format.html { render :new }
        format.json { render json: @ascendencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ascendencias/1
  # PATCH/PUT /ascendencias/1.json
  def update
    respond_to do |format|
      if @ascendencia.update(ascendencia_params)
        format.html { redirect_to @ascendencia, notice: 'Ascendencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @ascendencia }
      else
        format.html { render :edit }
        format.json { render json: @ascendencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ascendencias/1
  # DELETE /ascendencias/1.json
  def destroy
    @ascendencia.destroy
    respond_to do |format|
      format.html { redirect_to ascendencias_url, notice: 'Ascendencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ascendencia
      @ascendencia = Ascendencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ascendencia_params
      params.require(:ascendencia).permit(:padre_id, :hijo_id)
    end
end
