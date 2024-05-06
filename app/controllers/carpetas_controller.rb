class CarpetasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy, :asigna, :desasignar]

  helper_method :sort_column, :sort_direction
  # GET /carpetas
  # GET /carpetas.json
  def index
    set_tabla('carpetas', perfil_activo.carpetas.order(:carpeta), false)
    set_tabla('ext-carpetas', perfil_activo.compartidas.order(:carpeta), false)
  end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
    if (@objeto.app_perfil.email == perfil_activo.email and @objeto.sha1.blank?)
      @objeto.sha1 = Digest::SHA1.hexdigest("#{perfil_activo} #{@objeto.carpeta}")
      @objeto.save
    end
    set_tabla('publicaciones', @objeto.publicaciones.order(sort_column + " " + sort_direction), true)
    set_tabla('filo_especies', @objeto.filo_especies.order(:filo_especie), false)
  end

  # GET /carpetas/new
  def new
    @objeto = perfil_activo.carpetas.new
  end

  def nuevo
    publicacion = Publicacion.find(params[:objeto_id])
    activo = perfil_activo
    unless params[:nueva_carpeta][:carpeta].blank?
      activo.carpetas.create(carpeta: params[:nueva_carpeta][:carpeta])
    end

    redirect_to "/publicaciones/#{publicacion.id}?html_options[menu]=Carpetas"
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
      carpeta = Carpeta.find_by(sha1: params[:compartir_carpeta][:clave].strip)
      unless carpeta.blank?
        unless perfil_activo.compartidas.ids.include?(carpeta.id)
          perfil_activo.compartidas << carpeta unless (carpeta.blank? or carpeta.app_perfil.email == perfil_activo.email)
        end
      end
    end

    redirect_to carpetas_path
  end

  def asigna
    activo = perfil_activo

    elemento = params[:class_name].constantize.find(params[:objeto_id])
    elemento.carpetas << @objeto

    if params[:class_name] == 'Publicacion'
      redirect_to "/publicos/publicacion/pid=#{elemento.id}"
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
      redirect_to "/publicos/publicacion/pid=#{elemento.id}"
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
      @redireccion = carpetas_path
    end

    # Only allow a list of trusted parameters through.
    def carpeta_params
      params.require(:carpeta).permit(:carpeta, :app_perfil_id, :equipo_id)
    end
end
