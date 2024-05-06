class CategoriasController < ApplicationController
#  before_action :authenticate_usuario!
#  before_action :inicia_sesion
  before_action :set_categoria, only: [:show, :edit, :update, :destroy, :asigna, :desasignar, :aceptar, :rechazar]

  helper_method :sort_column, :sort_direction

  # GET /categorias
  # GET /categorias.json
  def index
  end

  # GET /categorias/1
  # GET /categorias/1.json
  def show
    set_tabla('publicaciones', @objeto.publicaciones.where(estado: 'publicada').order(sort_column + " " + sort_direction), true)
#    @coleccion = {}
#    @coleccion['publicaciones'] = @objeto.publicaciones.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page])
#    @paginate = true
  end

  # GET /categorias/new
  def new
    @objeto = Categoria.new
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
        format.html { redirect_to @redireccion, notice: 'Categoría fue exitósamente creada.' }
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
        format.html { redirect_to @redireccion, notice: 'Categoría fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # VERIFICADO
  # Asigna publicación a categoría
  def asigna
    elemento = params[:class_name].constantize.find(params[:objeto_id])

    elemento.categorias << @objeto

    etiqueta = Etiqueta.where(publicacion_id: elemento.id).find_by(categoria_id: @objeto.id)
    unless etiqueta.blank?
      etiqueta.asociado_por = perfil_activo.id
      etiqueta.save
    end

    redirect_to "/publicos/publicacion/pid=#{elemento.id}"
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

  # VERIFICADO
  # DesAsigna publicación a categoría
  def desasignar
    elemento = params[:class_name].constantize.find(params[:objeto_id])
    elemento.categorias.delete(@objeto)

    redirect_to "/publicos/publicacion/pid=#{elemento.id}"
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
      format.html { redirect_to @redireccion, notice: 'Categoría fue exitósamente eliminada.' }
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
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'areas_categorias')}"
    end

    # Only allow a list of trusted parameters through.
    def categoria_params
      params.require(:categoria).permit(:categoria, :perfil_id, :base)
    end
end
