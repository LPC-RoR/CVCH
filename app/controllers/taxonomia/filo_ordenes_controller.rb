class Taxonomia::FiloOrdenesController < ApplicationController
  before_action :set_filo_orden, only: [:show, :edit, :update, :destroy, :arriba, :abajo]
  before_action :carga_solo_sidebar, only: %i[ show new edit create update ]
  after_action :reordenar, only: :destroy

  include Sidebar

  # GET /filo_ordenes
  # GET /filo_ordenes.json
  def index
    @coleccion = FiloOrden.all
  end

  # GET /filo_ordenes/1
  # GET /filo_ordenes/1.json
  def show
  end

  # GET /filo_ordenes/new
  def new
    @objeto = FiloOrden.new(orden: FiloOrden.all.count + 1)
  end

  # GET /filo_ordenes/1/edit
  def edit
  end

  # POST /filo_ordenes
  # POST /filo_ordenes.json
  def create
    @objeto = FiloOrden.new(filo_orden_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo de elemento fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_ordenes/1
  # PATCH/PUT /filo_ordenes/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_orden_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tipo de elemento fue exitósamente actualizado.' }
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

  # DELETE /filo_ordenes/1
  # DELETE /filo_ordenes/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tipo de elemento fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_orden
      @objeto = FiloOrden.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'tipos')}"
    end

    # Only allow a list of trusted parameters through.
    def filo_orden_params
      params.require(:filo_orden).permit(:orden, :filo_orden)
    end
end
