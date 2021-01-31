class InstitucionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_institucion, only: [:show, :edit, :update, :destroy]

  # GET /instituciones
  # GET /instituciones.json
  def index
    @coleccion = Institucion.all
  end

  # GET /instituciones/1
  # GET /instituciones/1.json
  def show
  end

  # GET /instituciones/new
  def new
    @objeto = Institucion.new
  end

  # GET /instituciones/1/edit
  def edit
  end

  # POST /instituciones
  # POST /instituciones.json
  def create
    @objeto = Institucion.new(institucion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Institucion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instituciones/1
  # PATCH/PUT /instituciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(institucion_params)
        format.html { redirect_to @objeto, notice: 'Institucion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instituciones/1
  # DELETE /instituciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to instituciones_url, notice: 'Institucion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_institucion
      @objeto = Institucion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def institucion_params
      params.require(:institucion).permit(:institucion)
    end
end
