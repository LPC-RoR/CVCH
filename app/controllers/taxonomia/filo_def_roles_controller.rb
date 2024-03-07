class Taxonomia::FiloDefRolesController < ApplicationController
  before_action :set_filo_def_rol, only: [:show, :edit, :update, :destroy]

  # GET /filo_def_roles
  # GET /filo_def_roles.json
  def index
    @coleccion = FiloDefRol.all
  end

  # GET /filo_def_roles/1
  # GET /filo_def_roles/1.json
  def show
  end

  # GET /filo_def_roles/new
  def new
    @objeto = FiloDefRol.new
  end

  # GET /filo_def_roles/1/edit
  def edit
  end

  # POST /filo_def_roles
  # POST /filo_def_roles.json
  def create
    @objeto = FiloDefRol.new(filo_def_rol_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo def rol was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_def_roles/1
  # PATCH/PUT /filo_def_roles/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_def_rol_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo def rol was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_def_roles/1
  # DELETE /filo_def_roles/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Filo def rol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_def_rol
      @objeto = FiloDefRol.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'interacciones')}"
    end

    # Only allow a list of trusted parameters through.
    def filo_def_rol_params
      params.require(:filo_def_rol).permit(:filo_def_rol)
    end
end
