class Taxonomia::FiloDefInteraccionesController < ApplicationController
  before_action :set_filo_def_interaccion, only: [:show, :edit, :update, :destroy, :agrega_rol, :elimina_rol ]

  # GET /filo_def_interacciones
  # GET /filo_def_interacciones.json
  def index
    @coleccion = FiloDefInteraccion.all
  end

  # GET /filo_def_interacciones/1
  # GET /filo_def_interacciones/1.json
  def show
  end

  # GET /filo_def_interacciones/new
  def new
    @objeto = FiloDefInteraccion.new
  end

  # GET /filo_def_interacciones/1/edit
  def edit
  end

  # POST /filo_def_interacciones
  # POST /filo_def_interacciones.json
  def create
    @objeto = FiloDefInteraccion.new(filo_def_interaccion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo def interaccion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_def_interacciones/1
  # PATCH/PUT /filo_def_interacciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_def_interaccion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo def interaccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def agrega_rol
    rol = FiloDefRol.find(params[:rid])
    unless rol.blank?
      FiloDefRolInteraccion.create(filo_def_rol_id: rol.id, filo_def_interaccion_id: @objeto.id, orden: @objeto.filo_def_roles.count + 1)
    end
#    @objeto.filo_def_roles << rol unless rol.blank?

    set_redireccion
    redirect_to @redireccion, notice: 'Rol ha sido agregado exitósamente a la interacción'
  end

  def elimina_rol
    rol = FiloDefRol.find(params[:rid])
    unless rol.blank?
      @objeto.filo_def_roles.delete(rol)
    end
    primero = @objeto.filo_def_rol_interacciones.first
    unless primero.blank?
      primero.orden = 1
      primero.save
    end
#    @objeto.filo_def_roles << rol unless rol.blank?

    set_redireccion
    redirect_to @redireccion, notice: 'Rol ha sido eliminado exitósamente a la interacción'
  end

  # DELETE /filo_def_interacciones/1
  # DELETE /filo_def_interacciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Filo def interaccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_def_interaccion
      @objeto = FiloDefInteraccion.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'interacciones')}"
    end

    # Only allow a list of trusted parameters through.
    def filo_def_interaccion_params
      params.require(:filo_def_interaccion).permit(:filo_def_interaccion)
    end
end
