class Taxonomia::FiloRolesController < ApplicationController
  before_action :set_filo_rol, only: [:show, :edit, :update, :destroy]

  # GET /filo_roles
  # GET /filo_roles.json
  def index
    @coleccion = FiloRol.all
  end

  # GET /filo_roles/1
  # GET /filo_roles/1.json
  def show
  end

  # GET /filo_roles/new
  def new
    @objeto = FiloRol.new
  end

  # GET /filo_roles/1/edit
  def edit
  end

  # POST /filo_roles
  # POST /filo_roles.json
  def create
    @objeto = FiloRol.new(filo_rol_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Filo rol was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_roles/1
  # PATCH/PUT /filo_roles/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_rol_params)
        format.html { redirect_to @objeto, notice: 'Filo rol was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_roles/1
  # DELETE /filo_roles/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to filo_roles_url, notice: 'Filo rol was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_rol
      @objeto = FiloRol.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_rol_params
      params.require(:filo_rol).permit(:filo_rol, :filo_especie_id, :filo_interaccion_id)
    end
end
