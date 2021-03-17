class ConceptosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_concepto, only: [:show, :edit, :update, :destroy]

  # GET /conceptos
  # GET /conceptos.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])
    if params[:html_options].blank?
      @tab = @activo.administrador.present? ? 'plataforma' : 'propios'
    else
      @tab = params[:html_options][:tab].blank? ? (@tab = @activo.administrador.present? ? 'plataforma' : 'propios') : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }

    @coleccion = {}
    case @tab
    when 'propios'
      ids_propios_totales = @activo.conceptos.ids
      ids_plataforma = Concepto.where(administracion: true).ids
      ids_propios = ids_propios_totales - ids_plataforma
      @coleccion['conceptos'] = Concepto.find(ids_propios)
    when 'plataforma'
      @coleccion['conceptos'] = Concepto.where(administracion: true)
    else
      ids_propios = @activo.conceptos.ids
      ids_plataforma = Concepto.where(administracion: true).ids
      ids_total = Concepto.all.ids
      ids_comunidad = ids_total - (ids_propios | ids_plataforma)
      @coleccion['conceptos'] = Concepto.find(ids_comunidad)
    end
  end

  # GET /conceptos/1
  # GET /conceptos/1.json
  def show
    if params[:html_options].blank?
      @tab = 'instancias'
    else
      @tab = params[:html_options][:tab].blank? ? 'instancias' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}

    @coleccion = {}
    @coleccion['instancias'] = @objeto.send(@tab)
  end

  # GET /conceptos/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.conceptos.new
  end

  # GET /conceptos/1/edit
  def edit
  end

  # POST /conceptos
  # POST /conceptos.json
  def create
    @objeto = Concepto.new(concepto_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Concepto was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conceptos/1
  # PATCH/PUT /conceptos/1.json
  def update
    respond_to do |format|
      if @objeto.update(concepto_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Concepto was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conceptos/1
  # DELETE /conceptos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Concepto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_concepto
      @objeto = Concepto.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/conceptos"
    end

    # Only allow a list of trusted parameters through.
    def concepto_params
      params.require(:concepto).permit(:concepto, :perfil_id, :administracion)
    end
end
