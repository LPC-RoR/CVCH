class Busqueda::IndIndicesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_ind_indice, only: [:show, :edit, :update, :destroy]

  # GET /ind_indices
  # GET /ind_indices.json
  def index
    @coleccion = IndIndice.all
  end

  # GET /ind_indices/1
  # GET /ind_indices/1.json
  def show
  end

  # GET /ind_indices/new
  def new
    @objeto = IndIndice.new
  end

  # GET /ind_indices/1/edit
  def edit
  end

  # POST /ind_indices
  # POST /ind_indices.json
  def create
    @objeto = IndIndice.new(ind_indice_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind indice was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_indices/1
  # PATCH/PUT /ind_indices/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_indice_params)
        format.html { redirect_to @objeto, notice: 'Ind indice was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_indices/1
  # DELETE /ind_indices/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_indices_url, notice: 'Ind indice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_indice
      @objeto = IndIndice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_indice_params
      params.require(:ind_indice).permit(:ind_clave_id, :class_name, :objeto_id)
    end
end
