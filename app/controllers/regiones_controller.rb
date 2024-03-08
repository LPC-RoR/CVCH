class RegionesController < ApplicationController
  before_action :set_region, only: [:show, :edit, :update, :destroy, :arriba, :abajo, :asigna, :desasigna ]
  before_action :carga_solo_sidebar, only: %i[ show new edit create update ]
  after_action :reordenar, only: :destroy

  include Sidebar

  # GET /regiones
  # GET /regiones.json
  def index
    @coleccion = Region.all
  end

  # GET /regiones/1
  # GET /regiones/1.json
  def show
  end

  # GET /regiones/new
  def new
    @objeto = Region.new(orden: Region.all.count + 1)
  end

  # GET /regiones/1/edit
  def edit
  end

  # POST /regiones
  # POST /regiones.json
  def create
    @objeto = Region.new(region_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Región fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regiones/1
  # PATCH/PUT /regiones/1.json
  def update
    respond_to do |format|
      if @objeto.update(region_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Región fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def arriba
    owner = @objeto.owner
    anterior = @objeto.anterior
    @objeto.orden -= 1
    @objeto.save
    anterior.orden += 1
    anterior.save

    redirect_to @objeto.redireccion
  end

  def abajo
    owner = @objeto.owner
    siguiente = @objeto.siguiente
    @objeto.orden += 1
    @objeto.save
    siguiente.orden -= 1
    siguiente.save

    redirect_to @objeto.redireccion
  end

  def reordenar
    @objeto.list.each_with_index do |val, index|
      unless val.orden == index + 1
        val.orden = index + 1
        val.save
      end
    end
  end

  def asigna
    destino = params[:o].constantize.find(params[:indice])
    destino.regiones << @objeto

    if params[:o] == 'FiloEspecie'
      redirect_to "/publicos/especies?indice=#{destino.id}"
    end
  end

  def desasigna
    destino = params[:o].constantize.find(params[:indice])
    destino.regiones.delete(@objeto)

    if params[:o] == 'FiloEspecie'
      redirect_to "/publicos/especies?indice=#{destino.id}"
    end
  end

  # DELETE /regiones/1
  # DELETE /regiones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Región fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @objeto = Region.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'regiones_lugares')}"
    end

    # Only allow a list of trusted parameters through.
    def region_params
      params.require(:region).permit(:region, :orden)
    end
end
