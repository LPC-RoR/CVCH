class CategoriasController < ApplicationController
#  before_action :authenticate_usuario!
#  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_categoria, only: [:show, :edit, :update, :destroy, :desasignar, :aceptar, :rechazar]

  helper_method :sort_column, :sort_direction
  # GET /categorias
  # GET /categorias.json
  def index
  end

  # GET /categorias/1
  # GET /categorias/1.json
  def show
    if params[:html_options].blank?
      @tab = 'publicaciones'
    else
      @tab = params[:html_options][:tab].blank? ? 'publicaciones' : params[:html_options][:tab]
    end
    @options = {'tab' => @tab}

    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.publicaciones.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page])
  end

  # GET /categorias/new
  def new
    @activo = Perfil.find(session[:perfil_activo]['id'])
    @objeto = @activo.aportes.new
  end

  # GET /categorias/1/edit
  def edit
  end

  # POST /categorias
  # POST /categorias.json
  def create
    @objeto = Categoria.new(categoria_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Categoria was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorias/1
  # PATCH/PUT /categorias/1.json
  def update
    respond_to do |format|
      if @objeto.update(categoria_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Categoria was successfully updated.' }
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

    unless params[:categoria_base][:categoria_id].blank?
      categoria     = Categoria.find(params[:categoria_base][:categoria_id])

      unless publicacion.categorias.ids.include?(categoria.id)
        publicacion.categorias << categoria

        etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(categoria_id: categoria.id)
        etiqueta.asociado_por = session[:perfil_activo]['id']
        etiqueta.save
      end
    end

    redirect_to publicacion
    
  end

  def aceptar
    case params[:class_name]
    when 'Publicacion'
      publicacion = Publicacion.find(params[:objeto_id])
      etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(categoria_id: @objeto.id)
      etiqueta.revisado = true
      etiqueta.save
    end

    redirect_to publicacion
  end

  def desasignar
    case params[:class_name]
    when 'Publicacion'
      publicacion = Publicacion.find(params[:objeto_id])
      @objeto.publicaciones.delete(publicacion)
    end

    redirect_to publicacion
  end

  def rechazar
    case params[:class_name]
    when 'Publicacion'
      publicacion = Publicacion.find(params[:objeto_id])
      etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(categoria_id: @objeto.id)
      etiqueta.revisado = false
      etiqueta.save
    end

    redirect_to publicacion
  end

  # DELETE /categorias/1
  # DELETE /categorias/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Categoria was successfully destroyed.' }
      format.json { head :no_content }
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

    def set_categoria
      @objeto = Categoria.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/rutas'
    end

    # Only allow a list of trusted parameters through.
    def categoria_params
      params.require(:categoria).permit(:categoria, :perfil_id, :base)
    end
end
