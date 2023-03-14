class EspeciesController < ApplicationController
#  before_action :authenticate_usuario!
#  before_action :inicia_sesion
  before_action :set_especie, only: [:show, :edit, :update, :destroy, :desasignar, :aceptar, :rechazar]

  helper_method :sort_column, :sort_direction
  # GET /especies
  # GET /especies.json
  def index

    @options = {}

    # INICIALIZA TABS
    @tabs = {
      menu: ['Estructura', 'Niveles de la estructura y Epecies no reconocidas']
    }

    @tabs.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @tabs[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @tabs[key][0] : params[:html_options][key.to_s]
      end
    end

    if @options[:menu] == 'Estructura'
      @filo_especie = params[:especie].blank? ? nil : FiloEspecie.find_by(filo_especie: params[:especie])
      if @filo_especie.blank?
        @especies_padres = []
        ultima_especie = nil
      else
        @especies_padres = [@filo_especie.parent]
        ultima_especie = @filo_especie.parent
        unless ultima_especie.blank?
          while ultima_especie.parent.present? do
            @especies_padres << ultima_especie.parent
            ultima_especie = ultima_especie.parent
          end
        end
        @elemento_padre = @filo_especie.filo_elemento.present? ? @filo_especie.filo_elemento : @especies_padres[0].filo_elemento
      end

      if params[:elemento].blank? and params[:especie].blank?
        @filo_elemento = FiloElemento.first
      elsif params[:elemento].blank?
        @filo_elemento = nil
      else
        @filo_elemento = FiloElemento.find_by(filo_elemento: params[:elemento])
      end 

      if @filo_elemento.blank?
        @elementos_padres = []
        ultimo_elemento = nil
      else
        @elementos_padres = [@filo_elemento.parent]
        ultimo_elemento = @filo_elemento.parent
        unless ultimo_elemento.blank?
          while ultimo_elemento.parent.present? do
            @elementos_padres << ultimo_elemento.parent
            ultimo_elemento = ultimo_elemento.parent
          end
        end
      end

      @elemento_base = FiloElemento.first
      @elementos_base = FiloElemento.where(filo_orden_id: nil).page(params[:page])
    else
      @coleccion = {}
      esp_ids = Especie.all.map {|esp| esp.id if esp.filo_especie_id.blank?}.compact
      @coleccion['especies'] = Especie.where(id: esp_ids).order(:especie).page(params[:page])
      @coleccion['filo_elementos'] = (@filo_elemento.blank? ? FiloElemento.where(false).page(params[:page]) :  @filo_elemento.children.page(params[:page]))
      @coleccion['filo_ordenes'] = FiloOrden.all.order(:orden).page(params[:page])
      @paginate = true
    end

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

    #aqui tengo que acceder a la lista de áreas disponibles para una especie
    areas_seleccion = []
    @objeto.publicaciones.each do |publicacion|
      areas_seleccion << publicacion.areas.map {|a| a.area}
    end

    @areas_seleccion = Area.find(Area.all.ids - @objeto.areas.ids)

    @coleccion['areas'] = @objeto.areas
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
        etiqueta.asociado_por = perfil_activo_id
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

  def libera_especie
    especie = Especie.find(params[:objeto_id])
    padre = especie.filo_elemento
    especie.filo_elemento_id = nil
    especie.save

    redirect_to "/especies?especie=#{padre.filo_elemento unless padre.blank?}"
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
