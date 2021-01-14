class RegistrosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_registro, only: [:show, :edit, :update, :destroy]

  # GET /registros
  # GET /registros.json
  def index
    @coleccion = Registro.all
  end

  # GET /registros/1
  # GET /registros/1.json
  def show
  end

  # GET /registros/new
  def new
    @objeto = Registro.new
  end

  # GET /registros/1/edit
  def edit
  end

  # POST /registros
  # POST /registros.json
  def create
    @objeto = Registro.new(registro_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Registro was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registros/1
  # PATCH/PUT /registros/1.json
  def update
    respond_to do |format|
      if @objeto.update(registro_params)
        format.html { redirect_to @objeto, notice: 'Registro was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registros/1
  # DELETE /registros/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to registros_url, notice: 'Registro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registro
      @objeto = Registro.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registro_params
      params.require(:registro).permit(:doi, :institucion_id)
    end
end
