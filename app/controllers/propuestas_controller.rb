class PropuestasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :carga_temas_ayuda
  before_action :set_propuesta, only: [:show, :edit, :update, :destroy, :elimina_propuesta]

  # GET /propuestas
  # GET /propuestas.json
  def index
    @coleccion = Propuesta.all
  end

  # GET /propuestas/1
  # GET /propuestas/1.json
  def show
  end

  # GET /propuestas/new
  def new
    @objeto = Propuesta.new
  end

  # GET /propuestas/1/edit
  def edit
  end

  # POST /propuestas
  # POST /propuestas.json
  def create
    @objeto = Propuesta.new(propuesta_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Propuesta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /propuestas/1
  # PATCH/PUT /propuestas/1.json
  def update
    respond_to do |format|
      if @objeto.update(propuesta_params)
        format.html { redirect_to @objeto, notice: 'Propuesta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /propuestas/1
  # DELETE /propuestas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to propuestas_url, notice: 'Propuesta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina_propuesta
    publicacion = @objeto.publicacion
    @objeto.delete

    redirect_to publicacion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_propuesta
      @objeto = Propuesta.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def propuesta_params
      params.require(:propuesta).permit(:instancia_id, :publicacion_id)
    end
end
