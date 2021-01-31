class ConceptosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_concepto, only: [:show, :edit, :update, :destroy]

  # GET /conceptos
  # GET /conceptos.json
  def index
    @coleccion = Concepto.all
  end

  # GET /conceptos/1
  # GET /conceptos/1.json
  def show
    if params[:html_options].blank?
      @tab = 'instancias'
    else
      @tab = params[:html_options][:tab].blank? ? 'instancias' : params[:html_options][:tab]
    end
    @coleccion = @objeto.send(@tab)
    @options = {'tab' => @tab}
  end

  # GET /conceptos/new
  def new
    @objeto = Concepto.new
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
      params.require(:concepto).permit(:concepto)
    end
end
