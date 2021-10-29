class EspeciesController < ApplicationController
#  before_action :authenticate_usuario!
#  before_action :inicia_sesion
  before_action :set_especie, only: [:show, :edit, :update, :destroy, :desasignar, :aceptar, :rechazar]

  helper_method :sort_column, :sort_direction
  # GET /especies
  # GET /especies.json
  def index
    @stat = {}
    Especie.all.each do |esp|
      if @stat[esp.publicaciones.count.to_s].present?
        @stat[esp.publicaciones.count.to_s] += 1
      else
        @stat[esp.publicaciones.count.to_s] = 1
      end
    end
    puts @stat
#    @muchas_ids = Especie.all.map {|esp| esp.id if esp.publicaciones.count > 9}.compact
#    @pocas_ids = Especie.all.map {|esp| esp.id if esp.publicaciones.count < 10}.compact

    @coleccion = {}
    @coleccion['especies'] = Especie.all.order(:especie)
  end

  # GET /especies/1
  # GET /especies/1.json
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

  # GET /especies/new
  def new
    @objeto = Especie.new
  end

  # GET /especies/1/edit
  def edit
  end

  # POST /especies
  # POST /especies.json
  def create
    @objeto = Especie.new(especie_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Especie was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /especies/1
  # PATCH/PUT /especies/1.json
  def update
    respond_to do |format|
      if @objeto.update(especie_params)
        format.html { redirect_to @objeto, notice: 'Especie was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def asigna

    publicacion = Publicacion.find(params[:publicacion_id])

    unless params[:especie_base][:especie].blank?
      especie_name = params[:especie_base][:especie].strip.downcase
      especie      = Especie.find_by(especie: especie_name)

      if especie.blank?
        especie    = Especie.create(especie: especie_name)
      end

      unless publicacion.especies.ids.include?(especie.id)
        publicacion.especies << especie

        etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(especie_id: especie.id)
        etiqueta.asociado_por = session[:perfil_activo]['id']
        etiqueta.save
      end
    end

    redirect_to "/publicaciones/#{publicacion.id}?html_options[tab]=Especies"
  end

  def desasignar
    elemento = params[:class_name].constantize.find(params[:objeto_id])
    elemento.especies.delete(@objeto)
    @objeto.delete if @objeto.send(params[:class_name].tableize).empty?

    redirect_to "/publicaciones/#{elemento.id}?html_options[tab]=Especies"
  end

  def aceptar
    case params[:class_name]
    when 'Publicacion'
      publicacion = Publicacion.find(params[:objeto_id])
      etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(especie_id: @objeto.id)
      etiqueta.revisado = true
      etiqueta.save
    end

    redirect_to publicacion
  end

  def rechazar
    case params[:class_name]
    when 'Publicacion'
      publicacion = Publicacion.find(params[:objeto_id])
      etiqueta = Etiqueta.where(publicacion_id: publicacion.id).find_by(especie_id: @objeto.id)
      etiqueta.revisado = false
      etiqueta.save
    end

    redirect_to publicacion
  end

  # DELETE /especies/1
  # DELETE /especies/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to especies_url, notice: 'Especie was successfully destroyed.' }
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

    def set_especie
      @objeto = Especie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def especie_params
      params.require(:especie).permit(:especie)
    end
end
