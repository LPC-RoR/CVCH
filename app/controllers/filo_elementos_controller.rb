class FiloElementosController < ApplicationController
  before_action :set_filo_elemento, only: [:show, :edit, :update, :destroy]

  # GET /filo_elementos
  # GET /filo_elementos.json
  def index
    @coleccion = FiloElemento.all
  end

  # GET /filo_elementos/1
  # GET /filo_elementos/1.json
  def show
  end

  # GET /filo_elementos/new
  def new
    if params[:class_name] == 'nil' or params[:objeto_id] == 'nil'
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
      elemento = FiloElemento.create(filo_elemento: params[:nuevo_elemento][:filo_elemento])
      padre.children << elemento unless padre.blank?
    end

    redirect_to "/especies?especie=#{padre.filo_elemento unless padre.blank?}"
  end

  def asigna_especie
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:asigna_especie][:especie].blank?
      nombre_especie = params[:asigna_especie][:especie]
      especies = Especie.where(especie: nombre_especie.downcase)
      unless especies.empty?
        especies.each do |esp|
          padre.especies << esp
        end
      end
    end

    redirect_to "/especies?especie=#{padre.filo_elemento unless padre.blank?}"
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
        format.html { redirect_to @redireccion, notice: 'Filo elemento was successfully created.' }
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
        format.html { redirect_to @redireccion, notice: 'Filo elemento was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_elementos/1
  # DELETE /filo_elementos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Filo elemento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def elimina
    @objeto = FiloElemento.find(params[:objeto_id])

    padre = @objeto.parent.blank? ? nil : @objeto.parent 
    padre.children.delete(@objeto) unless @objeto.parent.blank?

    @objeto.delete

    redirect_to "/especies?especie=#{padre.filo_elemento unless padre.blank?}"
  end

  def elimina_base
    FiloElemento.delete_all

    redirect_to "/especies"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redireccion
      @redireccion = '/especies'
    end

    # Only allow a list of trusted parameters through.
    def filo_elemento_params
      params.require(:filo_elemento).permit(:filo_elemento)
    end
end
