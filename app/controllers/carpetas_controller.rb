class CarpetasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :carga_temas_ayuda
  before_action :set_carpeta, only: [:show, :edit, :update, :destroy, :desasignar]

  helper_method :sort_column, :sort_direction
  # GET /carpetas
  # GET /carpetas.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    @coleccion = {}
    @coleccion['carpetas'] =  @activo.carpetas
    end

  # GET /carpetas/1
  # GET /carpetas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'publicaciones'
    else
      @tab = params[:html_options][:tab].blank? ? 'publicaciones' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}

    @coleccion = {}
    @coleccion[@tab] = @objeto.send(@tab).order(sort_column + " " + sort_direction).page(params[:page])
  end

  # GET /carpetas/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.carpetas.new
  end

  def nuevo
    @equipo = Equipo.find(params[:equipo_id])
    if params[:nueva_carpeta][:carpeta].present?
      @equipo.carpetas << Carpeta.create(carpeta: params[:nueva_carpeta][:carpeta])
    end
    redirect_to @equipo
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

  def asigna
    @activo = Perfil.find(session[:perfil_activo]['id'])

    publicacion = Publicacion.find(params[:publicacion_id])

    unless params[:carpeta_base][:carpeta_id].blank?
      carpeta     = Carpeta.find(params[:carpeta_base][:carpeta_id])

      ids_carpetas_base = @activo.carpetas.map {|c| c.id if Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
      ids_carpetas_tema = @activo.carpetas.map {|c| c.id unless Carpeta::NOT_MODIFY.include?(c.carpeta)}.compact
      ids_activo = (ids_carpetas_base | ids_carpetas_tema)
      ids_publicacion = publicacion.carpetas.ids & ids_activo

      if ids_carpetas_base.include?(params[:carpeta_base][:carpeta_id].to_i)
        publicacion.carpetas.each do |cpta|
          publicacion.carpetas.delete(cpta)
        end
      end
      publicacion.carpetas << carpeta
    end

    redirect_to publicacion
    
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
    case params[:class_name]
    when 'Publicacion'
      elemento = Publicacion.find(params[:objeto_id])
      @objeto.publicaciones.delete(elemento)
    when 'Equipo'
      elemento = Equipo.find(params[:objeto_id])
      @objeto.equipos.delete(elemento)
    end

    redirect_to elemento
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
