class Help::PasosController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_paso, only: [:show, :edit, :update, :destroy]

  # GET /pasos
  # GET /pasos.json
  def index
    @coleccion = Paso.all
  end

  # GET /pasos/1
  # GET /pasos/1.json
  def show
  end

  # GET /pasos/new
  def new
    @objeto = Paso.new(tutorial_id: params[:tutorial_id])
  end

  # GET /pasos/1/edit
  def edit
  end

  # POST /pasos
  # POST /pasos.json
  def create
    @objeto = Paso.new(paso_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Paso was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pasos/1
  # PATCH/PUT /pasos/1.json
  def update
    respond_to do |format|
      if @objeto.update(paso_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Paso was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pasos/1
  # DELETE /pasos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Paso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paso
      @objeto = Paso.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.tutorial
    end

    # Only allow a list of trusted parameters through.
    def paso_params
      params.require(:paso).permit(:orden, :paso, :detalle, :tutorial_id)
    end
end
