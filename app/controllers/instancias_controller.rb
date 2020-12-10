class InstanciasController < ApplicationController
  before_action :set_instancia, only: [:show, :edit, :update, :destroy, :elimina_instancia]

  # GET /instancias
  # GET /instancias.json
  def index
    @coleccion = Instancia.all
  end

  # GET /instancias/1
  # GET /instancias/1.json
  def show
    if params[:html_options].blank?
      @tab = 'publicaciones'
    else
      @tab = params[:html_options][:tab].blank? ? 'publicaciones' : params[:html_options][:tab]
    end
    @coleccion = @objeto.publicaciones.page(params[:page])
    @options = {'tab' => @tab}
  end

  # GET /instancias/new
  def new
    @objeto = Instancia.new
  end

  def nuevo
    unless params[:instancia_nuevo][:instancia].blank?
      @publicacion = Publicacion.find(params[:publicacion_id])
      @sha1 = Digest::SHA1.hexdigest(params[:instancia_nuevo][:instancia].strip.downcase)
      @existente = Instancia.find_by(sha1: @sha1)
      if @existente.blank?
        @existente = Instancia.create(instancia: params[:instancia_nuevo][:instancia].strip, sha1: @sha1)
      end
      unless @publicacion.instancias.ids.include?(@existente.id)
        @publicacion.instancias << @existente
      end
    end

    redirect_to @publicacion
  end

  # GET /instancias/1/edit
  def edit
  end

  # POST /instancias
  # POST /instancias.json
  def create
    @objeto = Instancia.new(instancia_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Instancia was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instancias/1
  # PATCH/PUT /instancias/1.json
  def update
    respond_to do |format|
      if @objeto.update(instancia_params)
        format.html { redirect_to @objeto, notice: 'Instancia was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instancias/1
  # DELETE /instancias/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to instancias_url, notice: 'Instancia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina_instancia
    @publicacion = Publicacion.find(params[:objeto_id])
    @publicacion.instancias.delete(@objeto)
    if @objeto.publicaciones.empty?
      @objeto.delete
    end
    redirect_to @publicacion
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instancia
      @objeto = Instancia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def instancia_params
      params.require(:instancia).permit(:instancia, :sha1, :concepto_id)
    end
end
