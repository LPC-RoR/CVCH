class AreasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_area, only: [:show, :edit, :update, :destroy, :desasignar]

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
    @coleccion = {}
    @coleccion['publicaciones'] = @objeto.papers.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page])
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
        format.html { redirect_to @redireccion, notice: 'Area was successfully created.' }
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
        format.html { redirect_to @redireccion, notice: 'Area was successfully updated.' }
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

    unless params[:area_base][:area_id].blank?
      area     = Area.find(params[:area_base][:area_id])

      publicacion.areas << area
    end

    redirect_to publicacion
    
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def desasignar
    publicacion = Publicacion.find(params[:objeto_id])

    @objeto.papers.delete(publicacion)

    redirect_to publicacion
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
      @redireccion = '/rutas'
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(:area)
    end
end
