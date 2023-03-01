class Busqueda::IndPalabrasController < ApplicationController
  before_action :inicia_sesion
  before_action :set_ind_palabra, only: [:show, :edit, :update, :destroy, :excluir, :reprocesar]

  include ProcesaEstructura

  # GET /ind_palabras
  # GET /ind_palabras.json
  def index
    @coleccion = IndPalabra.all
  end

  # GET /ind_palabras/1
  # GET /ind_palabras/1.json
  def show
    @coleccion = {}
    @coleccion['ind_expresiones'] = @objeto.ind_expresiones.order(:ind_expresion)
    @coleccion['ind_indices'] = (@objeto.ind_clave.present? ? @objeto.ind_clave.ind_indices : [])
  end

  # GET /ind_palabras/new
  def new
    @objeto = IndPalabra.new
  end

  # GET /ind_palabras/1/edit
  def edit
  end

  # POST /ind_palabras
  # POST /ind_palabras.json
  def create
    @objeto = IndPalabra.new(ind_palabra_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind palabra was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_palabras/1
  # PATCH/PUT /ind_palabras/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_palabra_params)
        format.html { redirect_to @objeto, notice: 'Ind palabra was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def reprocesar
    estructura = @objeto.ind_estructura
    @objeto.ind_clave.ind_indices.each do |indice|
      if indice.class_name == 'Publicacion'
        publicacion = indice.class_name.constantize.find(indice.objeto_id)
        desindexa_registro(publicacion)
        indexa_registro(publicacion)
      end
      if @objeto.ind_clave.ind_indices.empty?
        @objeto.ind_clave.delete
        @objeto.delete
      end
    end

    redirect_to estructura
  end

  # DELETE /ind_palabras/1
  # DELETE /ind_palabras/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_palabras_url, notice: 'Ind palabra was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_palabra
      @objeto = IndPalabra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_palabra_params
      params.require(:ind_palabra).permit(:ind_palabra, :ind_lenguaje_id, :ind_clave_id)
    end
end
