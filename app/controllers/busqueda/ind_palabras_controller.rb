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
    indices_ids = (@objeto.ind_clave.present? ? @objeto.ind_clave.ind_indices.ids : [])
    indices_ids = indices_ids.union(@objeto.ind_indices.ids).uniq
    indices = IndIndice.where(id: indices_ids)
    @coleccion['publicaciones'] = Publicacion.where(id: indices.map {|i| i.objeto_id})
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
    coleccion_ids = @objeto.ind_clave.blank? ? [] : @objeto.ind_clave.ind_indices.where(class_name: 'Publicacion').ids

    ids = coleccion_ids.union(@objeto.ind_indices.where(class_name: 'Publicacion').ids)
    indices = IndIndice.where(id: ids.uniq)

    noticia = "n_indices = #{indices.count}"

    indices.each do |indice|
      if [6653].include?(indice.objeto_id)
        indice.delete
      else
      publicacion = indice.class_name.constantize.find(indice.objeto_id)
      if publicacion.blank?
        indice.delete
      else
        noticia = noticia + "| #{publicacion.id}"
        desindexa_registro(publicacion)
        indexa_registro(publicacion)
      end
      end
    end

    n_indices = @objeto.ind_clave.blank? ? @objeto.ind_indices.count : @objeto.ind_clave.ind_indices.count + @objeto.ind_indices.count

    if n_indices == 0
      @objeto.ind_clave.delete unless @objeto.ind_clave.blank?
      @objeto.delete
    end

    redirect_to estructura, notice: noticia
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
