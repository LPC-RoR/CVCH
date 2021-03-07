class EtiquetasController < ApplicationController
  before_action :set_etiqueta, only: [:show, :edit, :update, :destroy]

  # GET /etiquetas
  # GET /etiquetas.json
  def index
    @coleccion = Etiqueta.all
  end

  # GET /etiquetas/1
  # GET /etiquetas/1.json
  def show
  end

  # GET /etiquetas/new
  def new
    @objeto = Etiqueta.new
  end

  # GET /etiquetas/1/edit
  def edit
  end

  # POST /etiquetas
  # POST /etiquetas.json
  def create
    @objeto = Etiqueta.new(etiqueta_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Etiqueta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etiquetas/1
  # PATCH/PUT /etiquetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(etiqueta_params)
        format.html { redirect_to @objeto, notice: 'Etiqueta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etiquetas/1
  # DELETE /etiquetas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to etiquetas_url, notice: 'Etiqueta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etiqueta
      @objeto = Etiqueta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def etiqueta_params
      params.require(:etiqueta).permit(:categoria_id, :publicacion_id, :especie_id)
    end
end
