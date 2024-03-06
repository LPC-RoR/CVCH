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

    # Se cargan los LMENU de Áreas, Categorías, Carpetas y Carpetas compartidas
    @sel_areas = Area.all.order(:area).map {|area| [area, area.papers.where(estado: 'publicada').count]}
    @sel_categorias = Categoria.all.order(:categoria).map {|categoria| [categoria, categoria.publicaciones.where(estado: 'publicada').count]}
    unless perfil_activo.blank?
      @sel_carpetas = perfil_activo.carpetas.order(:carpeta).map {|carpeta| [carpeta, carpeta.publicaciones.where(estado: 'publicada').count]}
      @sel_compartidas = perfil_activo.compartidas.order(:carpeta).map {|compartida| [compartida, compartida.publicaciones.where(estado: 'publicada').count]}
    end

    if params[:html_options].blank?
      @objeto = @sel_areas[0][0]
    else
      @objeto = params[:html_options][:modelo].constantize.find(params[:html_options][:id])
    end
    @modelo = @objeto.class.name
    @id = @objeto.id

    # no lo puse al comienzo porque necesita el valor de @modelo
    set_tab( :menu, [['Publicaciones', true], ['Especies', @modelo == 'Area'], ['Citas', @modelo == 'Carpeta']] )
    @options[:modelo] = @modelo
    @options[:id] = @id

    if params[:search].blank?
      set_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Area'
      set_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Categoria'
      set_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Carpeta'
      set_tabla('citas', @objeto.publicaciones.order(:author), false) if @options[:menu] == 'Citas'
    else
      set_tabla('publicaciones', busqueda_publicaciones(params[:search], 'Publicacion'), true)
    end

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

    def sel_estado(elemento)
      (elemento.class.name == 'Carpeta' and elemento.app_perfil.email != perfil_activo.email) ? 'compartida' : 'normal'
    end

    def sel_campo(elemento)
      clase = elemento.class.name
      id = elemento.id
      clase.constantize.find(id).send(clase.downcase)
    end

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
