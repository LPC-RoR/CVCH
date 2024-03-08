class Ecosistemas::EcoPisosController < ApplicationController
  before_action :set_eco_piso, only: [:show, :edit, :update, :destroy]
  after_action :reordenar, only: :destroy

  # GET /eco_pisos
  # GET /eco_pisos.json
  def index
    @coleccion = EcoPiso.all
  end

  # GET /eco_pisos/1
  # GET /eco_pisos/1.json
  def show
  end

  # GET /eco_pisos/new
  def new
    formacion = params[:fid]
    @objeto = EcoPiso.new(eco_formacion_id: params[:fid], orden: formacion.eco_pisos.count + 1)
  end

  # GET /eco_pisos/1/edit
  def edit
  end

  # POST /eco_pisos
  # POST /eco_pisos.json
  def create
    @objeto = EcoPiso.new(eco_piso_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eco_pisos/1
  # PATCH/PUT /eco_pisos/1.json
  def update
    respond_to do |format|
      if @objeto.update(eco_piso_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente actualizado.' }
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

  # DELETE /eco_pisos/1
  # DELETE /eco_pisos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Piso de vegetación fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def reordenar
      @objeto.list.each_with_index do |val, index|
        unless val.orden == index + 1
          val.orden = index + 1
          val.save
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_eco_piso
      @objeto = EcoPiso.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'formaciones_pisos')}"
    end

    # Only allow a list of trusted parameters through.
    def eco_piso_params
      params.require(:eco_piso).permit(:eco_formacion_id, :eco_piso)
    end
end
