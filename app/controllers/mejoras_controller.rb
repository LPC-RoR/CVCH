class MejorasController < ApplicationController
  before_action :authenticate_usuario!, except: :show
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_mejora, only: [:show, :edit, :update, :destroy]

  # GET /mejoras
  # GET /mejoras.json
  def index
    @coleccion = Mejora.all
  end

  # GET /mejoras/1
  # GET /mejoras/1.json
  def show
  end

  # GET /mejoras/new
  def new
    @objeto = Mejora.new
  end

  def nuevo
    case params[:class_name]
    when 'Publicacion'
      @objeto = Publicacion.find(params[:objeto_id])
    end
    
    owner_id = usuario_signed_in? ? session[:perfil_activo]['id'] : nil

    unless params[:mejora_base][:observacion].blank? or params[:mejora_base][:detalle].blank?
      @objeto.mejoras.create(mejora: params[:mejora_base][:mejora], detalle: params[:mejora_base][:detalle], owner_id: owner_id)
    end

    redirect_to @objeto
  end

  # GET /mejoras/1/edit
  def edit
  end

  # POST /mejoras
  # POST /mejoras.json
  def create
    @objeto = Mejora.new(mejora_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Mejora was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mejoras/1
  # PATCH/PUT /mejoras/1.json
  def update
    respond_to do |format|
      if @objeto.update(mejora_params)
        format.html { redirect_to @objeto, notice: 'Mejora was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mejoras/1
  # DELETE /mejoras/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to mejoras_url, notice: 'Mejora was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mejora
      @objeto = Mejora.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mejora_params
      params.require(:mejora).permit(:mejora, :detalle, :publicacion_id, :owner_id)
    end
end
