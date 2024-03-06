class Autenticacion::CfgValoresController < ApplicationController
  before_action :set_cfg_valor, only: [:show, :edit, :update, :destroy]

  # GET /cfg_valores
  # GET /cfg_valores.json
  def index
    @coleccion = CfgValor.all
  end

  # GET /cfg_valores/1
  # GET /cfg_valores/1.json
  def show
  end

  # GET /cfg_valores/new
  def new
    @objeto = CfgValor.new
  end

  # GET /cfg_valores/1/edit
  def edit
  end

  # POST /cfg_valores
  # POST /cfg_valores.json
  def create
    @objeto = CfgValor.new(cfg_valor_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Configuracion fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cfg_valores/1
  # PATCH/PUT /cfg_valores/1.json
  def update
    respond_to do |format|
      if @objeto.update(cfg_valor_params)
        format.html { redirect_to @objeto, notice: 'Configuracion fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cfg_valores/1
  # DELETE /cfg_valores/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to cfg_valores_url, notice: 'Configuracion fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfg_valor
      @objeto = CfgValor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cfg_valor_params
      params.require(:cfg_valor).permit(:cfg_valor, :tipo, :numero, :palabra, :texto, :fecha, :fecha_hora, :app_version_id, :check_box)
    end
end
