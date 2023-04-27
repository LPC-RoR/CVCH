class FiloEspeciesController < ApplicationController
  before_action :set_filo_especie, only: [:show, :edit, :update, :destroy]

  helper_method :sort_column, :sort_direction

  # GET /filo_especies
  # GET /filo_especies.json
  def index
    @coleccion = FiloEspecie.all
  end

  # GET /filo_especies/1
  # GET /filo_especies/1.json
  def show
    init_tabla('publicaciones', Publicacion.where(id: @objeto.publicaciones_ids).order(sort_column + " " + sort_direction), true)
    add_tabla('filo_especies', @objeto.children, false )
    add_tabla('sinonimos-filo_especies', @objeto.sinonimos, false)

    add_tabla('especies', @objeto.especies, false)
  end

  # GET /filo_especies/new
  def new
    @objeto = FiloEspecie.new(filo_elemento_id: params[:filo_elemento_id])
  end

  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie][:filo_especie].blank?
      especie = FiloEspecie.create(filo_especie: params[:nueva_especie][:filo_especie].downcase, nombre_comun: params[:nueva_especie][:nombre_comun])
      padre.filo_especies << especie unless padre.blank?
    end

    redirect_to padre
  end

  def nuevo_child
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie_child][:filo_especie].blank?
      textos = params[:nueva_especie_child][:filo_especie].split('|')
      tex_espe = textos[0]
      tex_ncom = textos.count == 2 ? textos[1] : nil
      especie = FiloEspecie.create(filo_especie: tex_espe.capitalize, nombre_comun: tex_ncom)
      padre.children << especie unless padre.blank?
    end

    redirect_to "/especies?especie=#{padre.filo_especie unless padre.blank?}"
  end

  # GET /filo_especies/1/edit
  def edit
  end

  # POST /filo_especies
  # POST /filo_especies.json
  def create
    @objeto = FiloEspecie.new(filo_especie_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo especie was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_especies/1
  # PATCH/PUT /filo_especies/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_especie_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Filo especie was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def nueva_subespecie
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:nueva_subespecie][:filo_especie].blank?
      check_filo_especie = FiloEspecie.find_by(filo_especie: params[:nueva_subespecie][:filo_especie].downcase)
      if check_filo_especie.blank?
        nueva = FiloEspecie.create(filo_especie: params[:nueva_subespecie][:filo_especie].downcase, nombre_comun: params[:nueva_subespecie][:nombre_comun].downcase, iucn: params[:nueva_subespecie][:iucn])
        filo_especie.children << nueva
      end
    end
    
    redirect_to filo_especie
  end

  def nuevo_sinonimo
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:nuevo_sinonimo][:sinonimo].blank?
      check_sinonimo = FiloEspecie.find_by(filo_especie: params[:nuevo_sinonimo][:sinonimo].downcase)
      if check_sinonimo.blank?
        sinonimo = FiloEspecie.create(filo_especie: params[:nuevo_sinonimo][:sinonimo].downcase)
        filo_especie.sinonimos << sinonimo
      end
    end
    
    redirect_to filo_especie
  end

  def asocia_etiqueta
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:asocia_etiqueta][:etiqueta].blank?
      etiqueta = params[:asocia_etiqueta][:etiqueta].match(/^\d+$/) ? Especie.find(params[:asocia_etiqueta][:etiqueta].to_i) : Especie.find_by(especie: params[:asocia_etiqueta][:etiqueta].downcase)
      filo_especie.especies << etiqueta unless etiqueta.blank?
    end

    redirect_to filo_especie
  end

  # DELETE /filo_especies/1
  # DELETE /filo_especies/1.json
  def destroy
    @objeto.destroy
    set_redireccion
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Filo especie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina
    @objeto = FiloEspecie.find(params[:objeto_id])

    if @objeto.padre.class.name == 'FiloEspecie'
      padre = @objeto.parent 
      padre.children.delete(@objeto)
    end

    @objeto.delete

    if @objeto.padre.class.name == 'FiloEspecie'
      redirect_to "/especies?especie=#{@objeto.padre.filo_especie}"
    else
      redirect_to "/especies?elemento=#{@objeto.padre.filo_elemento}"
    end
  end

  private

    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_filo_especie
      @objeto = FiloEspecie.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.padre
    end

    # Only allow a list of trusted parameters through.
    def filo_especie_params
      params.require(:filo_especie).permit(:filo_especie, :nombre_comun, :iucn, :filo_elemento_id)
    end
end
