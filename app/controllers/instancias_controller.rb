class InstanciasController < ApplicationController
  before_action :set_instancia, only: [:show, :edit, :update, :destroy]

  # GET /instancias
  # GET /instancias.json
  def index
    @instancias = Instancia.all
  end

  # GET /instancias/1
  # GET /instancias/1.json
  def show
  end

  # GET /instancias/new
  def new
    @instancia = Instancia.new
  end

  # GET /instancias/1/edit
  def edit
  end

  # POST /instancias
  # POST /instancias.json
  def create
    @instancia = Instancia.new(instancia_params)

    respond_to do |format|
      if @instancia.save
        format.html { redirect_to @instancia, notice: 'Instancia was successfully created.' }
        format.json { render :show, status: :created, location: @instancia }
      else
        format.html { render :new }
        format.json { render json: @instancia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instancias/1
  # PATCH/PUT /instancias/1.json
  def update
    respond_to do |format|
      if @instancia.update(instancia_params)
        format.html { redirect_to @instancia, notice: 'Instancia was successfully updated.' }
        format.json { render :show, status: :ok, location: @instancia }
      else
        format.html { render :edit }
        format.json { render json: @instancia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instancias/1
  # DELETE /instancias/1.json
  def destroy
    @instancia.destroy
    respond_to do |format|
      format.html { redirect_to instancias_url, notice: 'Instancia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instancia
      @instancia = Instancia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instancia_params
      params.require(:instancia).permit(:instancia, :sha1, :concepto_id)
    end
end
