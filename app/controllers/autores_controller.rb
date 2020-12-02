class AutoresController < ApplicationController
  before_action :set_autor, only: [:show, :edit, :update, :destroy]

  # GET /autores
  # GET /autores.json
  def index
    @coleccion = Autor.all
  end

  # GET /autores/1
  # GET /autores/1.json
  def show
    @tab = params[:tab].blank? ? 'publicaciones' : params[:tab]
    @coleccion = @objeto.publicaciones.where(estado: 'publicada').page(params[:page])
  end

  # GET /autores/new
  def new
    @objeto = Autor.new
  end

  # GET /autores/1/edit
  def edit
  end

  # POST /autores
  # POST /autores.json
  def create
    @objeto = Autor.new(autor_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Autor was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autores/1
  # PATCH/PUT /autores/1.json
  def update
    respond_to do |format|
      if @objeto.update(autor_params)
        format.html { redirect_to @objeto, notice: 'Autor was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autores/1
  # DELETE /autores/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to autores_url, notice: 'Autor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_autor
      @objeto = Autor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def autor_params
      params.require(:autor).permit(:investigador_id, :publicacion_id)
    end
end
