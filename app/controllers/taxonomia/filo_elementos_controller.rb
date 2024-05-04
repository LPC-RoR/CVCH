class Taxonomia::FiloElementosController < ApplicationController
  before_action :set_filo_elemento, only: [:show, :edit, :update, :destroy, :libera_area, :subir, :bajar, :trae_hijos]

  # GET /filo_elementos
  # GET /filo_elementos.json
  def index
    set_tabla('filo_elementos', FiloElemento.all.order(:filo_elemento), true)
  end

  # GET /filo_elementos/1
  # GET /filo_elementos/1.json
  def show
    set_tabla('filo_elementos', @objeto.children, false)
    set_tabla('filo_especies', @objeto.filo_especies, false)
  end

  # GET /filo_elementos/new
  def new
    if params[:class_name] == 'nil' or params[:objeto_id] == 'nil' or params[:class_name].blank? or params[:objeto_id].blank?
      @objeto = FiloElemento.new
    else
      @padre = params[:class_name].constantize.find(params[:objeto_id])
      @objeto = @padre.children.new
      @padre.children << @objeto
    end
  end

  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nuevo_elemento][:filo_elemento].blank?
      textos = params[:nuevo_elemento][:filo_elemento].split('|')
      tex_elem = textos[0]
      tex_desc = textos.count == 2 ? textos[1] : nil
      elemento = FiloElemento.create(filo_elemento: tex_elem.capitalize, descripcion: tex_desc)
      padre.children << elemento unless padre.blank?
    end

    redirect_to "/especies?elemento=#{padre.filo_elemento unless padre.blank?}"
  end

  def asigna_especie
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:asigna_especie][:especie].blank?
      nombre_especie = params[:asigna_especie][:especie]
      [nombre_especie.downcase, nombre_especie].uniq.each do |nombre|
        especies = Especie.where(especie: nombre)
        unless especies.empty?
          especies.each do |esp|
            padre.especies << esp
          end
        end
      end
    end

    redirect_to "/especies?especie=#{padre.filo_elemento unless padre.blank?}"
  end

  def asigna_area
    area = params[:class_name].constantize.find(params[:objeto_id])
    unless params[:asigna_area][:nombre_elemento].blank?
      elemento = FiloElemento.find_by(filo_elemento: params[:asigna_area][:nombre_elemento])
      area.filo_elementos << elemento
    end
    
    redirect_to area
  end

  def libera_area
    area = params[:class_name].constantize.find(params[:objeto_id])
    
    @objeto.area_id = nil
    @objeto.save
    
    redirect_to area
  end

  # GET /filo_elementos/1/edit
  def edit
  end

  # POST /filo_elementos
  # POST /filo_elementos.json
  def create
    @objeto = FiloElemento.new(filo_elemento_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Elemento fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_elementos/1
  # PATCH/PUT /filo_elementos/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_elemento_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Elemento fue exitósamente actualizado.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def cambio_padre
    filo_elemento = FiloElemento.find(params[:objeto_id])
    unless params[:cambio_padre][:nuevo_padre].blank?
      nuevo_padre = FiloElemento.find_by(filo_elemento: params[:cambio_padre][:nuevo_padre].downcase)
      unless nuevo_padre.blank?
        padre = filo_elemento.parent
        padre.children.delete(filo_elemento) unless padre.blank?

        nuevo_padre.children << filo_elemento
      end
    end

    redirect_to filo_elemento
  end

  #  REutilizado
  def nuevo_hijo
    unless (params[:nuevo_hijo][:filo_orden_id].blank? or params[:nuevo_hijo][:filo_elemento].blank?)
      check_filo_elemento = FiloElemento.find_by(filo_elemento: params[:nuevo_hijo][:filo_elemento].downcase)
      if check_filo_elemento.blank?
        nuevo = FiloElemento.create(filo_orden_id: params[:nuevo_hijo][:filo_orden_id], filo_elemento: params[:nuevo_hijo][:filo_elemento].downcase, descripcion: params[:nuevo_hijo][:descripcion], area_id: params[:nuevo_hijo][:area_id])
        unless params[:objeto_id].blank?
          filo_elemento = FiloElemento.find(params[:objeto_id])
          filo_elemento.children << nuevo
        end
      end
    end

    redireccion =  ( params[:objeto_id].blank? ? '/publicos/taxonomia' : "/publicos/taxonomia?indice=#{params[:objeto_id]}")
    
    redirect_to redireccion
  end

  def subir
    # @objeto.parent SIEMPRE EXISTE
    if dog?
      padre = @objeto.parent
      abuelo = @objeto.parent.parent
      padre.children.delete(@objeto)

      abuelo.children << @objeto unless abuelo.blank?
    end

    redirect_to "/publicos/taxonomia?indice=#{@objeto.id}"
  end

  def bajar
    if dog?
      padre = @objeto.parent
      padre.children.delete(@objeto) unless padre.blank?
      nuevo_padre = FiloElemento.find(params[:indice])
      nuevo_padre.children << @objeto
    end

    redirect_to "/publicos/taxonomia?indice=#{@objeto.id}"
  end

  # DELETE /filo_elementos/1
  # DELETE /filo_elementos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Elemento fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  def elimina
    @objeto = FiloElemento.find(params[:objeto_id])

    padre = @objeto.parent.blank? ? nil : @objeto.parent 
    padre.children.delete(@objeto) unless @objeto.parent.blank?

    @objeto.delete

    redirect_to "/especies?elemento=#{padre.filo_elemento unless padre.blank?}"
  end

  def elimina_base
    FiloElemento.delete_all

    redirect_to "/especies"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_elemento
      @objeto = FiloElemento.find(params[:id])
    end

    def set_redireccion
      @redireccion = "/publicos/taxonomia?indice=#{@objeto.id}"
    end

    # Only allow a list of trusted parameters through.
    def filo_elemento_params
      params.require(:filo_elemento).permit(:filo_orden_id, :filo_elemento, :descripcion, :mma_ok, :revisar, :area_id, :list_field)
    end
end
