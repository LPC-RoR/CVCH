class Busqueda::IndClavesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_ind_clave, only: [:show, :edit, :update, :destroy]

  # GET /ind_claves
  # GET /ind_claves.json
  def index
    @coleccion = IndClave.all
  end

  # GET /ind_claves/1
  # GET /ind_claves/1.json
  def show
  end

  # GET /ind_claves/new
  def new
    @objeto = IndClave.new
  end

  # GET /ind_claves/1/edit
  def edit
  end

  # POST /ind_claves
  # POST /ind_claves.json
  def create
    @objeto = IndClave.new(ind_clave_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind clave was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_claves/1
  # PATCH/PUT /ind_claves/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_clave_params)
        format.html { redirect_to @objeto, notice: 'Ind clave was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_claves/1
  # DELETE /ind_claves/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_claves_url, notice: 'Ind clave was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_clave
      @objeto = IndClave.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_clave_params
      params.require(:ind_clave).permit(:ind_clave)
    end
end
