class CarpetasController < ApplicationController
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy]

  # GET /carpetas
  # GET /carpetas.json
  def index
    @coleccion = Carpeta.all
  end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
  end

  # GET /carpetas/new
  def new
    @objeto = Carpeta.new
  end

  # GET /carpetas/1/edit
  def edit
  end

  # POST /carpetas
  # POST /carpetas.json
  def create
    @objeto = Carpeta.new(carpeta_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Carpeta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpetas/1
  # PATCH/PUT /carpetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(carpeta_params)
        format.html { redirect_to @objeto, notice: 'Carpeta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carpetas/1
  # DELETE /carpetas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to carpetas_url, notice: 'Carpeta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carpeta
      @objeto = Carpeta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :investigador_id, :equipo_id)
    end
end
