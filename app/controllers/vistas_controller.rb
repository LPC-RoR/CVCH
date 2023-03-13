class VistasController < ApplicationController
  before_action :authenticate_usuario!, only: [:escritorio]
  before_action :inicia_sesion
  before_action :set_vista, only: [:show, :edit, :update, :destroy]
  before_action :check_areas, only: [:index]

  helper_method :sort_column, :sort_direction

  include ProcesaEstructura

  # GET /vistas
  # GET /vistas.json
  def index

    @options = {}
    # INICILIZA SELECTOR
    @sels = {
      area: Area.all.map {|a| a.area},
      categoria: Categoria.all.map {|c| c.categoria}
    }

    @sels.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @sels[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @sels[key][0] : params[:html_options][key.to_s]
      end
    end

    # INICIALIZA TABS
    @tabs = {
      menu: ['Áreas', 'Categorías'],
      areas: ['Publicaciones', 'Especies']
    }

    @tabs.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @tabs[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @tabs[key][0] : params[:html_options][key.to_s]
      end
    end

    if @options[:menu] == 'Áreas'
      @list_selector = Area.all.map {|a| [a.area, a.papers.where(estado: 'publicada').count]}

      @area = Area.find_by(area: @options[:area])
    elsif @options[:menu] == 'Categorías'
      @list_selector = Categoria.all.map {|c| [c.categoria, c.publicaciones.where(estado: 'publicada').count]}

      @categoria = Categoria.find_by(categoria: @options[:categoria])
    end

      @coleccion = {}

    if params[:search].blank?
      @coleccion['publicaciones'] = @area.papers.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page]) if @options[:menu] == 'Áreas'
      @coleccion['publicaciones'] = @categoria.publicaciones.where(estado: 'publicada').order(sort_column + " " + sort_direction).page(params[:page]) if @options[:menu] == 'Categorías'
    else
      @coleccion['publicaciones'] = busqueda_publicaciones(params[:search], 'Publicacion').order(sort_column + " " + sort_direction).page(params[:page])
    end

    @paginate = true

  end

  def escritorio
    @activo = perfil_activo
    @list_selector = @activo.carpetas.all.map {|c| [c.carpeta, c.publicaciones.count]}

    @options = {}
    # INICILIZA SELECTOR
    @sels = {
      carpetas: @activo.carpetas.all.map {|c| c.carpeta}
    }

    @sels.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @sels[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @sels[key][0] : params[:html_options][key.to_s]
      end
    end

    # INICIALIZA TABS
    @tabs = {
      menu: ['Publicaciones', 'Citas']
    }

    @tabs.keys.each do |key|
      if params[:html_options].blank?
        @options[key] = @tabs[key][0]
      else
        @options[key] = params[:html_options][key.to_s].blank? ? @tabs[key][0] : params[:html_options][key.to_s]
      end
    end

    @carpeta = @activo.carpetas.find_by(carpeta: @options[:carpetas])

#    if params[:html_options].blank?
#      @carpeta = @activo.carpetas.first
#      @tab = 'Publicaciones'
#    else
#      @carpeta = params[:html_options]['sel'].blank? ? @activo.carpetas.first : @activo.carpetas.find_by(carpeta: params[:html_options]['sel'])
#      @tab = params[:html_options]['tab'].blank? ? 'Publicaciones' : params[:html_options]['tab']
#    end

#    @sel = @carpeta.carpeta
#    @options = {'sel' => @sel, 'tab' => @tab}

    @coleccion = {}
    @coleccion['publicaciones'] = @carpeta.publicaciones.order(sort_column + " " + sort_direction).page(params[:page]) if @tab == 'Publicaciones'
    @coleccion['citas']  = @carpeta.publicaciones.order(:author)

    @coleccion['carpetas'] = @activo.carpetas
  end

  def graficos
    @days_hash = Usuario.group_by_day(:created_at).count
    total = 0
    @days_hash.keys.each do |dia|
      @days_hash[dia] = @days_hash[dia] + total
      total = @days_hash[dia]
    end

    @accesos_dia = {
      'Marzo'      => 54,
      'Abril'      => 61,
      'Mayo'       => 69,
      'Junio'      => 63,
      'Julio'      => 65,
      'Agosto'     => 73,
      'Septiembre' => 89,
      'octubre'    => 91
    }

    @busquedas = {
      'Marzo'      => 6,
      'Abril'      => 24,
      'Mayo'       => 78,
      'Junio'      => 146,
      'Julio'      => 378,
      'Agosto'     => 422,
      'Septiembre' => 699,
      'octubre'    => 896
    }

  end

  # GET /vistas/1
  # GET /vistas/1.json
  def show
  end

  # GET /vistas/new
  def new
    @objeto = Vista.new
  end

  # GET /vistas/1/edit
  def edit
  end

  # POST /vistas
  # POST /vistas.json
  def create
    @objeto = Vista.new(vista_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Vista was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vistas/1
  # PATCH/PUT /vistas/1.json
  def update
    respond_to do |format|
      if @objeto.update(vista_params)
        format.html { redirect_to @objeto, notice: 'Vista was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vistas/1
  # DELETE /vistas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to vistas_url, notice: 'Vista was successfully destroyed.' }
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

    def set_vista
      @objeto = Vista.find(params[:id])
    end

    def check_areas
      if Area.all.empty?
        Area::NOT_MODIFY.each do |area|
          Area.create(area: area)
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def vista_params
      params.fetch(:vista, {})
    end
end
