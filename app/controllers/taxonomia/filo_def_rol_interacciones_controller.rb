class Taxonomia::FiloDefRolInteraccionesController < ApplicationController
  before_action :set_filo_def_rol_interaccion, only: [:show, :edit, :update, :destroy, :arriba, :abajo ]

  # GET /filo_def_rol_interacciones
  # GET /filo_def_rol_interacciones.json
  def index
    @coleccion = FiloDefRolInteraccion.all
  end

  # GET /filo_def_rol_interacciones/1
  # GET /filo_def_rol_interacciones/1.json
  def show
  end

  # GET /filo_def_rol_interacciones/new
  def new
    @objeto = FiloDefRolInteraccion.new
  end

  # GET /filo_def_rol_interacciones/1/edit
  def edit
  end

  # POST /filo_def_rol_interacciones
  # POST /filo_def_rol_interacciones.json
  def create
    @objeto = FiloDefRolInteraccion.new(filo_def_rol_interaccion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Filo def rol interaccion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_def_rol_interacciones/1
  # PATCH/PUT /filo_def_rol_interacciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_def_rol_interaccion_params)
        format.html { redirect_to @objeto, notice: 'Filo def rol interaccion was successfully updated.' }
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

  # DELETE /filo_def_rol_interacciones/1
  # DELETE /filo_def_rol_interacciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to filo_def_rol_interacciones_url, notice: 'Filo def rol interaccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_def_rol_interaccion
      @objeto = FiloDefRolInteraccion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_def_rol_interaccion_params
      params.require(:filo_def_rol_interaccion).permit(:rol_a_id, :rol_b_id)
    end
end
