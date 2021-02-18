class InstanciasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :carga_temas_ayuda
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
    @options = {'tab' => @tab}

    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.publicaciones.page(params[:page])
    @coleccion['conceptos'] = @objeto.conceptos
    @coleccion['aprobaciones'] = @objeto.aprobaciones
  end

  # GET /instancias/new
  def new
    @objeto = Instancia.new
  end

  def nuevo
    # Aqui nos ganamos lo porotos!
    publicacion = Publicacion.find(params[:publicacion_id])

    unless params[:instancia_nuevo][:instancia].blank? or params[:instancia_nuevo][:concepto_id].blank?
      @activo = Perfil.find(session[:perfil_activo]['id'])

      concepto = Concepto.find(params[:instancia_nuevo][:concepto_id])
      # generamos el SHA1 del texto ingresado strip & downcase
      @sha1 = Digest::SHA1.hexdigest(params[:instancia_nuevo][:instancia].strip.downcase)
      # vemos si la instancia existe
      instancia = Instancia.find_by(sha1: @sha1)

      if instancia.blank?
        # 1.- Crear Instancia
        instancia = Instancia.create(instancia: params[:instancia_nuevo][:instancia].downcase.strip, sha1: @sha1)
        concepto.instancias << instancia
      else
        # 1.- Instancia
        # si existe aún debemos verifiacar que esté asociado al concepto que queremos vincular
        unless instancia.conceptos.ids.include?(concepto.id)
          concepto.instancias << instancia
        end
      end
      # 2.- Enrutar
      if concepto.perfil.administrador.present? or concepto.perfil.id == @activo.id
        unless publicacion.instancias.ids.include?(instancia.id)
          publicacion.instancias << instancia
          ruta = Ruta.where(publicacion_id: publicacion.id).find_by(instancia_id: instancia.id)
          ruta.perfil_id = @activo.id
          ruta.save
        end
      else
        unless publicacion.instancias.ids.include?(instancia.id)
          publicacion.pendientes << instancia
          propuesta = Propuesta.where(publicacion_id: publicacion.id).find_by(instancia_id: instancia.id)
          propuesta.perfil_id = @activo.id
          propuesta.save
        end
      end
    end

    redirect_to publicacion
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
