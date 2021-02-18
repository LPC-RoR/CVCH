class ObservacionesController < ApplicationController
  before_action :set_observacion, only: [:show, :edit, :update, :destroy]

  # GET /observaciones
  # GET /observaciones.json
  def index
    @coleccion = Observacion.all
  end

  # GET /observaciones/1
  # GET /observaciones/1.json
  def show
  end

  # GET /observaciones/new
  def new
  end

  def nuevo
    case params[:class_name]
    when 'Publicacion'
      @objeto = Publicacion.find(params[:objeto_id])
    end

    owner_id = usuario_signed_in? ? session[:perfil_activo]['id'] : nil
    
    @objeto.observaciones.create(observacion: params[:observacion_base][:observacion], detalle: params[:observacion_base][:detalle], owner_id: owner_id)

    redirect_to @objeto
  end

  # GET /observaciones/1/edit
  def edit
  end

  # POST /observaciones
  # POST /observaciones.json
  def create
    @objeto = Observacion.new(observacion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Observacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /observaciones/1
  # PATCH/PUT /observaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(observacion_params)
        format.html { redirect_to @objeto, notice: 'Observacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observaciones/1
  # DELETE /observaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to observaciones_url, notice: 'Observacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_observacion
      @objeto = Observacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def observacion_params
      params.require(:observacion).permit(:observacion, :detalle, :publicacion_id, :owner_id)
    end
end
