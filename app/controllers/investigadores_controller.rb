class InvestigadoresController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_investigador, only: [:show, :edit, :update, :destroy, :perfil]

  # GET /investigadores
  # GET /investigadores.json
  def index
    @coleccion = Investigador.all
  end

  # GET /investigadores/1
  # GET /investigadores/1.json
  def show
    if params[:html_options].blank?
      @tab = 'publicaciones'
    else
      @tab = params[:html_options][:tab].blank? ? 'publicaciones' : params[:html_options][:tab]
    end
#    @estado = params[:estado].blank? ? @tab.classify.constantize::ESTADOS[0] : params[:estado]
    # tenemos que cubrir todos los casos
    # 1. has_many : }
    @coleccion = @objeto.send(@tab).page(params[:page]) #.where(estado: @estado)
    @options = {'tab' => @tab}
  end

  def perfil
  end

  # GET /investigadores/new
  def new
    @objeto = Investigador.new
  end

  # GET /investigadores/1/edit
  def edit
  end

  # POST /investigadores
  # POST /investigadores.json
  def create
    @objeto = Investigador.new(investigador_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Investigador was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /investigadores/1
  # PATCH/PUT /investigadores/1.json
  def update
    respond_to do |format|
      if @objeto.update(investigador_params)
        format.html { redirect_to @objeto, notice: 'Investigador was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investigadores/1
  # DELETE /investigadores/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to investigadores_url, notice: 'Investigador was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investigador
      @objeto = Investigador.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def investigador_params
      params.require(:investigador).permit(:investigador, :orcid, :email, :departamento_id)
    end
end
