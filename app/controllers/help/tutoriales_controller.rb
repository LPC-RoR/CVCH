class Help::TutorialesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]

  # GET /tutoriales
  # GET /tutoriales.json
  def index
    @coleccion = Tutorial.all
  end

  # GET /tutoriales/1
  # GET /tutoriales/1.json
  def show
    @coleccion = {}
    @coleccion['pasos'] = @objeto.pasos.order(:orden)
  end

  # GET /tutoriales/new
  def new
    @objeto = Tutorial.new(tema_ayuda_id: params[:tema_ayuda_id])
  end

  # GET /tutoriales/1/edit
  def edit
  end

  # POST /tutoriales
  # POST /tutoriales.json
  def create
    @objeto = Tutorial.new(tutorial_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tutorial was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutoriales/1
  # PATCH/PUT /tutoriales/1.json
  def update
    respond_to do |format|
      if @objeto.update(tutorial_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Tutorial was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutoriales/1
  # DELETE /tutoriales/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Tutorial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @objeto = Tutorial.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.tema_ayuda
    end

    # Only allow a list of trusted parameters through.
    def tutorial_params
      params.require(:tutorial).permit(:orden, :tutorial, :detalle, :tema_ayuda_id)
    end
end
