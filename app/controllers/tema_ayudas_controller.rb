class TemaAyudasController < ApplicationController
  before_action :inicia_session
  before_action :carga_temas_ayuda
  before_action :set_tema_ayuda, only: [:show, :edit, :update, :destroy]

  # GET /tema_ayudas
  # GET /tema_ayudas.json
  def index
    @coleccion = {}
    @coleccion['tema_inicio'] = TemaAyuda.where(tipo: 'inicio')
    @coleccion['tema_tutorial'] = TemaAyuda.where(tipo: 'tema')
  end

  # GET /tema_ayudas/1
  # GET /tema_ayudas/1.json
  def show
    @coleccion = {}
    @coleccion['tutoriales'] = @objeto.tutoriales.order(:orden)
  end

  # GET /tema_ayudas/new
  def new
    @objeto = TemaAyuda.new
  end

  def nuevo
    tipo = params[:tema_ayuda_base][:tipo].blank? ? 'tema' : params[:tema_ayuda_base][:tipo]
    orden = params[:tema_ayuda_base][:orden]
    tema_ayuda = params[:tema_ayuda_base][:tema_ayuda]
    detalle = params[:tema_ayuda_base][:detalle]
    
    TemaAyuda.create(tipo: tipo, orden: orden, tema_ayuda: tema_ayuda, detalle: detalle)

    redirect_to tema_ayudas_path
  end

  # GET /tema_ayudas/1/edit
  def edit
  end

  # POST /tema_ayudas
  # POST /tema_ayudas.json
  def create
    @objeto = TemaAyuda.new(tema_ayuda_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema ayuda was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tema_ayudas/1
  # PATCH/PUT /tema_ayudas/1.json
  def update
    respond_to do |format|
      if @objeto.update(tema_ayuda_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tema ayuda was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tema_ayudas/1
  # DELETE /tema_ayudas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tema ayuda was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema_ayuda
      @objeto = TemaAyuda.find(params[:id])
    end

    def set_redireccion
      @redireccion = tema_ayudas_path
    end

    # Only allow a list of trusted parameters through.
    def tema_ayuda_params
      params.require(:tema_ayuda).permit(:orden, :tema_ayuda, :detalle, :tipo)
    end
end
