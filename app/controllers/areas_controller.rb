class AreasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :set_area, only: [:show, :edit, :update, :destroy, :desasignar, :asigna]

  helper_method :sort_column, :sort_direction
  # GET /areas
  # GET /areas.json
  def index
    @coleccion = {}
    @coleccion['areas'] = Area.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    set_tabla('publicaciones', @objeto.papers.where(estado: 'publicada').order(sort_column + " " + sort_direction), true)
    set_tabla('filo_elementos', @objeto.filo_elementos.order(:filo_elemento), false)
  end

  # GET /areas/new
  def new
    @objeto = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @objeto = Area.new(area_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Área fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @objeto.update(area_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Área fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # VERIFICADO
  # Asigna publicación a Àrea
  def asigna
    elemento = params[:class_name].constantize.find(params[:objeto_id])
    elemento.areas << @objeto

    case elemento.class.name
    when 'Publicacion'
      redirect_to "/publicos/publicacion?pid=#{elemento.id}"
    when 'Especie'
      redirect_to elemento
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Área fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  # VERIFICADO
  # DesAsigna publicación a Àrea
  def desasignar
    elemento = params[:class_name].constantize.find(params[:objeto_id])

    case elemento.class.name
    when 'Publicacion'
      @objeto.papers.delete(elemento)
      redirect_to "/publicos/publicacion?pid=#{elemento.id}"
    when 'Especie'
      elemento.areas.delete(@objeto)
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

    def set_area
      @objeto = Area.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/tablas?tb=#{tb_index(:admin, 'areas_categorias')}"
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(:area)
    end
end
