class IdiomasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_idioma, only: [:show, :edit, :update, :destroy]

  # GET /idiomas
  # GET /idiomas.json
  def index
    @coleccion = Idioma.all
  end

  # GET /idiomas/1
  # GET /idiomas/1.json
  def show
  end

  # GET /idiomas/new
  def new
    @objeto = Idioma.new
  end

  # GET /idiomas/1/edit
  def edit
  end

  # POST /idiomas
  # POST /idiomas.json
  def create
    @objeto = Idioma.new(idioma_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Idioma was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /idiomas/1
  # PATCH/PUT /idiomas/1.json
  def update
    respond_to do |format|
      if @objeto.update(idioma_params)
        format.html { redirect_to @objeto, notice: 'Idioma was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idiomas/1
  # DELETE /idiomas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to idiomas_url, notice: 'Idioma was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idioma
      @objeto = Idioma.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def idioma_params
      params.require(:idioma).permit(:idioma)
    end
end
