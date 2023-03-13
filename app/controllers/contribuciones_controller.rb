class ContribucionesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_contribucion, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction
  # GET /contribuciones
  # GET /contribuciones.json
  def index
    @activo = perfil_activo

    @options = {}
    # INICIALIZA TABS
    @tabs = {
      menu: ['ingreso', 'contribucion', 'publicada']
    }

    @tabs.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @tabs[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @tabs[key][0] : params[:html_options][key.to_s]
      end
    end

#    init_tab(['ingreso', 'contribucion', 'publicada'], params)
#    @options = { 'tab' => @tab }

    @coleccion = {}
    @coleccion['publicaciones'] = @activo.contribuciones.where(estado: @tab).order(sort_column + " " + sort_direction).page(params[:page])
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
    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_contribucion
      @objeto = Contribucion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contribucion_params
      params.fetch(:contribucion, {})
    end
end
