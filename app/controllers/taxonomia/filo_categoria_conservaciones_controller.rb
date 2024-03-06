class Taxonomia::FiloCategoriaConservacionesController < ApplicationController
  before_action :set_filo_categoria_conservacion, only: [:show, :edit, :update, :destroy]
  before_action :carga_solo_sidebar, only: %i[ show new edit create update ]

  include Sidebar

  # GET /filo_categoria_conservaciones
  # GET /filo_categoria_conservaciones.json
  def index
    @coleccion = FiloCategoriaConservacion.all
  end

  # GET /filo_categoria_conservaciones/1
  # GET /filo_categoria_conservaciones/1.json
  def show
  end

  # GET /filo_categoria_conservaciones/new
  def new
    @objeto = FiloCategoriaConservacion.new
  end

  # GET /filo_categoria_conservaciones/1/edit
  def edit
  end

  # POST /filo_categoria_conservaciones
  # POST /filo_categoria_conservaciones.json
  def create
    @objeto = FiloCategoriaConservacion.new(filo_categoria_conservacion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Categoría de conservación fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_categoria_conservaciones/1
  # PATCH/PUT /filo_categoria_conservaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_categoria_conservacion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Categoría de conservación fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_categoria_conservaciones/1
  # DELETE /filo_categoria_conservaciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Categoría de conservación fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_categoria_conservacion
      @objeto = FiloCategoriaConservacion.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'categorias_fuentes')}"
    end

    # Only allow a list of trusted parameters through.
    def filo_categoria_conservacion_params
      params.require(:filo_categoria_conservacion).permit(:codigo, :filo_categoria_conservacion)
    end
end
