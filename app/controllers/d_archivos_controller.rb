class DArchivosController < ApplicationController
  before_action :set_d_archivo, only: %i[ show edit update destroy ]

  # GET /d_archivos or /d_archivos.json
  def index
    @coleccion = DArchivo.all
  end

  # GET /d_archivos/1 or /d_archivos/1.json
  def show
  end

  # GET /d_archivos/new
  def new
    @objeto = DArchivo.new
  end

  # GET /d_archivos/1/edit
  def edit
  end

  # POST /d_archivos or /d_archivos.json
  def create
    @objeto = DArchivo.new(d_archivo_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to d_archivo_url(@objeto), notice: "D archivo was successfully created." }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /d_archivos/1 or /d_archivos/1.json
  def update
    respond_to do |format|
      if @objeto.update(d_archivo_params)
        format.html { redirect_to d_archivo_url(@objeto), notice: "D archivo was successfully updated." }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /d_archivos/1 or /d_archivos/1.json
  def destroy
    @objeto.destroy!

    respond_to do |format|
      format.html { redirect_to d_archivos_url, notice: "D archivo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_d_archivo
      @objeto = DArchivo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def d_archivo_params
      params.require(:d_archivo).permit(:archivo)
    end
end
