class Taxonomia::FiloTipoEspeciesController < ApplicationController
  before_action :set_filo_tipo_especie, only: [:show, :edit, :update, :destroy]
  before_action :carga_solo_sidebar, only: %i[ show new edit create update ]

  include Sidebar

  # GET /filo_tipo_especies
  # GET /filo_tipo_especies.json
  def index
    @coleccion = FiloTipoEspecie.all
  end

  # GET /filo_tipo_especies/1
  # GET /filo_tipo_especies/1.json
  def show
  end

  # GET /filo_tipo_especies/new
  def new
    @objeto = FiloTipoEspecie.new
  end

  # GET /filo_tipo_especies/1/edit
  def edit
  end

  # POST /filo_tipo_especies
  # POST /filo_tipo_especies.json
  def create
    @objeto = FiloTipoEspecie.new(filo_tipo_especie_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo de especie fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_tipo_especies/1
  # PATCH/PUT /filo_tipo_especies/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_tipo_especie_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo de especie fue exitósamente actualizado.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_tipo_especies/1
  # DELETE /filo_tipo_especies/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tipo de especie fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_tipo_especie
      @objeto = FiloTipoEspecie.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/app_recursos/administracion?id=#{get_elemento_id(controller_name, 'Tipos de Especie')}" 
    end

    # Only allow a list of trusted parameters through.
    def filo_tipo_especie_params
      params.require(:filo_tipo_especie).permit(:filo_tipo_especie)
    end
end
