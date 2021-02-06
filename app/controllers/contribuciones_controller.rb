class ContribucionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_contribucion, only: [:show, :edit, :update, :destroy]

  # GET /contribuciones
  # GET /contribuciones.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    if params[:html_options].blank?
      @tab = 'ingreso'
    else
      @tab = params[:html_options][:tab].blank? ? 'ingreso' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }

    @coleccion = {}
    @coleccion['publicaciones'] = @activo.contribuciones.where(estado: @tab).page(params[:page])
  end

  # GET /contribuciones/1
  # GET /contribuciones/1.json
  def show
  end

  # GET /contribuciones/new
  def new
    @objeto = Contribucion.new
  end

  # GET /contribuciones/1/edit
  def edit
  end

  # POST /contribuciones
  # POST /contribuciones.json
  def create
    @objeto = Contribucion.new(contribucion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Contribucion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribuciones/1
  # PATCH/PUT /contribuciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(contribucion_params)
        format.html { redirect_to @objeto, notice: 'Contribucion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribuciones/1
  # DELETE /contribuciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to contribuciones_url, notice: 'Contribucion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribucion
      @objeto = Contribucion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contribucion_params
      params.fetch(:contribucion, {})
    end
end
