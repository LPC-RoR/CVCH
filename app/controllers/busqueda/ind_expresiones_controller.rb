class Busqueda::IndExpresionesController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_ind_expresion, only: [:show, :edit, :update, :destroy]

  # GET /ind_expresiones
  # GET /ind_expresiones.json
  def index
    @coleccion = IndExpresion.all
  end

  # GET /ind_expresiones/1
  # GET /ind_expresiones/1.json
  def show
  end

  # GET /ind_expresiones/new
  def new
    @objeto = IndExpresion.new
  end

  # GET /ind_expresiones/1/edit
  def edit
  end

  # POST /ind_expresiones
  # POST /ind_expresiones.json
  def create
    @objeto = IndExpresion.new(ind_expresion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind expresion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_expresiones/1
  # PATCH/PUT /ind_expresiones/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_expresion_params)
        format.html { redirect_to @objeto, notice: 'Ind expresion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_expresiones/1
  # DELETE /ind_expresiones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_expresiones_url, notice: 'Ind expresion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_expresion
      @objeto = IndExpresion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_expresion_params
      params.require(:ind_expresion).permit(:ind_expresion)
    end
end
