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

    @sel_table = {
      areas: Area.all.order(:area),
      categorias: Categoria.all.order(:categoria),
    }
    @sel_table[:carpetas] = perfil_activo.carpetas.order(:carpeta) unless perfil_activo.blank?

    @sel_table_list = []
    @sel_table.keys.each do |key_table|
      @sel_table_list << ['tabla', @sel_table[key_table].first.class.name]
      @sel_table[key_table].each do |elemento|
        @sel_table_list << ['elemento', elemento.class.name, elemento.send(elemento.class.name.downcase), elemento.sel_table.count]
      end
    end

    if params[:html_options].blank?
      @objeto = @sel_table[:areas].first
    elsif params[:html_options][:modelo] == 'Area'
      @objeto = params[:html_options][:modelo].constantize.find_by(area: params[:html_options][:elemento])
    elsif params[:html_options][:modelo] == 'Categoria'
      @objeto = params[:html_options][:modelo].constantize.find_by(categoria: params[:html_options][:elemento])
    elsif params[:html_options][:modelo] == 'Carpeta'
      @objeto = params[:html_options][:modelo].constantize.find_by(carpeta: params[:html_options][:elemento])
    end      
    @modelo = @objeto.class.name
    @elemento = @objeto.send(@objeto.class.name.downcase)

    # no lo puse al comienzo porque necesita el valor de @modelo
    init_tab( { menu: [['Publicaciones', true], ['Especies', @modelo == 'Area'], ['Citas', @modelo == 'Carpeta']] }, true )
    @options[:modelo] = @modelo
    @options[:elemento] = @elemento

    if params[:search].blank?
      init_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Area'
      init_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Categoria'
      init_tabla('publicaciones', @objeto.sel_table.order(sort_column + " " + sort_direction), true) if @modelo == 'Carpeta'
      init_tabla('citas', @objeto.publicaciones.order(:author), false) if @options[:menu] == 'Citas'
    else
      init_tabla('publicaciones', busqueda_publicaciones(params[:search], 'Publicacion').order(sort_column + " " + sort_direction), true)
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
