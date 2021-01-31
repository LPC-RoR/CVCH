class HerenciasController < ApplicationController
  before_action :set_herencia, only: [:show, :edit, :update, :destroy]

  # GET /herencias
  # GET /herencias.json
  def index
    @herencias = Herencia.all
  end

  # GET /herencias/1
  # GET /herencias/1.json
  def show
  end

  # GET /herencias/new
  def new
    @herencia = Herencia.new
  end

  # GET /herencias/1/edit
  def edit
  end

  # POST /herencias
  # POST /herencias.json
  def create
    @herencia = Herencia.new(herencia_params)

    respond_to do |format|
      if @herencia.save
        format.html { redirect_to @herencia, notice: 'Herencia was successfully created.' }
        format.json { render :show, status: :created, location: @herencia }
      else
        format.html { render :new }
        format.json { render json: @herencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /herencias/1
  # PATCH/PUT /herencias/1.json
  def update
    respond_to do |format|
      if @herencia.update(herencia_params)
        format.html { redirect_to @herencia, notice: 'Herencia was successfully updated.' }
        format.json { render :show, status: :ok, location: @herencia }
      else
        format.html { render :edit }
        format.json { render json: @herencia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /herencias/1
  # DELETE /herencias/1.json
  def destroy
    @herencia.destroy
    respond_to do |format|
      format.html { redirect_to herencias_url, notice: 'Herencia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_herencia
      @herencia = Herencia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def herencia_params
      params.require(:herencia).permit(:equipo_id, :carpeta_id)
    end
end
