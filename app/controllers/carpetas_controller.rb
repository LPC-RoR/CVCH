class CarpetasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy, :asigna, :desasignar]

  helper_method :sort_column, :sort_direction
  # GET /carpetas
  # GET /carpetas.json
  def index
    @activo = perfil_activo

    @coleccion = {}
    @coleccion['carpetas'] =  @activo.carpetas
    end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
    if (@objeto.app_perfil.email == perfil_activo.email and @objeto.sha1.blank?)
      @objeto.sha1 = Digest::SHA1.hexdigest("#{perfil_activo} #{@objeto.carpeta}")
      @objeto.save
    end
    init_tabla('publicaciones', @objeto.publicaciones.order(sort_column + " " + sort_direction), true)
#    @coleccion = {}
#    @coleccion['publicaciones'] = @objeto.publicaciones.order(sort_column + " " + sort_direction).page(params[:page])
  end

  # GET /carpetas/new
  def new
    @activo = perfil_activo
    @objeto = @activo.carpetas.new
  end

  def nuevo
    publicacion = Publicacion.find(params[:objeto_id])
    activo = perfil_activo
    unless params[:nueva_carpeta][:carpeta].blank?
      activo.carpetas.create(carpeta: params[:nueva_carpeta][:carpeta])
    end

    redirect_to "/publicaciones/#{publicacion.id}?html_options[tab]=Carpetas"
  end

  # GET /carpetas/1/edit
  def edit
  end

  # POST /carpetas
  # POST /carpetas.json
  def create
    @objeto = Carpeta.new(carpeta_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carpetas/1
  # PATCH/PUT /carpetas/1.json
  def update
    respond_to do |format|
      if @objeto.update(carpeta_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Carpeta was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def compartir_carpeta
    unless params[:compartir_carpeta][:clave].blank?
      carpeta = Carpeta.find_by(sha1: params[:compartir_carpeta][:clave])
      perfil_activo.compartidas << carpeta unless (carpeta.blank? or carpeta.app_perfil.email == perfil_activo.email)
    end

    redirect_to vistas_path
  end

  def asigna
    activo = perfil_activo

    elemento = params[:class_name].constantize.find(params[:objeto_id])
    elemento.carpetas << @objeto

    if params[:class_name] == 'Publicacion'
      redirect_to "/publicaciones/#{elemento.id}?html_options[menu]=Carpetas"
    elsif
      redirect_to elemento
    end
  end

  # DELETE /carpetas/1
  # DELETE /carpetas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Carpeta was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def desasignar
    elemento = params[:class_name].constantize.find(params[:objeto_id])
    @objeto.send(params[:class_name].tableize).delete(elemento)

    if params[:class_name] == 'Publicacion'
      redirect_to "/publicaciones/#{elemento.id}?html_options[menu]=Carpetas"
    elsif
      redirect_to elemento
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_carpeta
      @objeto = Carpeta.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/vistas/escritorio'
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :perfil_id, :equipo_id)
    end
end
