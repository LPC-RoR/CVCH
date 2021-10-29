class RutasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_ruta, only: [:show, :edit, :update, :destroy, :elimina_ruta]

  # GET /rutas
  # GET /rutas.json
  def index
    @coleccion = {}

    @coleccion['areas'] = Area.all
    @coleccion['categorias'] = Categoria.all.order(:categoria)
    @coleccion['especies'] = Especie.all.order(:especie).page(params[:page])
#    @coleccion['investigadores'] = Investigador.all.order(:investigador)
#    @coleccion['revistas'] = Revista.all.order(:revista)
  end

  # GET /rutas/1
  # GET /rutas/1.json
  def show
  end

  # GET /rutas/new
  def new
    @objeto = Ruta.new
  end

  # GET /rutas/1/edit
  def edit
  end

  # POST /rutas
  # POST /rutas.json
  def create
    @objeto = Ruta.new(ruta_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ruta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rutas/1
  # PATCH/PUT /rutas/1.json
  def update
    respond_to do |format|
      if @objeto.update(ruta_params)
        format.html { redirect_to @objeto, notice: 'Ruta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rutas/1
  # DELETE /rutas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to rutas_url, notice: 'Ruta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina_ruta
    publicacion = @objeto.publicacion
    @objeto.delete

    redirect_to publicacion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ruta
      @objeto = Ruta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ruta_params
      params.require(:ruta).permit(:instancia_id, :publicacion_id)
    end
end
