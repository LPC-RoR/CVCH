class FiloEspeciesController < ApplicationController
  before_action :set_filo_especie, only: [:show, :edit, :update, :destroy]

  # GET /filo_especies
  # GET /filo_especies.json
  def index
    @filo_especies = FiloEspecie.all
  end

  # GET /filo_especies/1
  # GET /filo_especies/1.json
  def show
  end

  # GET /filo_especies/new
  def new
    @filo_especie = FiloEspecie.new
  end

  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie][:filo_especie].blank?
      textos = params[:nueva_especie][:filo_especie].split('|')
      tex_espe = textos[0]
      tex_ncom = textos.count == 2 ? textos[1] : nil
      especie = FiloEspecie.create(filo_especie: tex_espe.capitalize, nombre_comun: tex_ncom)
      padre.filo_especies << especie unless padre.blank?
    end

    redirect_to "/especies?elemento=#{padre.filo_elemento unless padre.blank?}"
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
    @filo_especie = FiloEspecie.new(filo_especie_params)

    respond_to do |format|
      if @filo_especie.save
        format.html { redirect_to @filo_especie, notice: 'Filo especie was successfully created.' }
        format.json { render :show, status: :created, location: @filo_especie }
      else
        format.html { render :new }
        format.json { render json: @filo_especie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_especies/1
  # PATCH/PUT /filo_especies/1.json
  def update
    respond_to do |format|
      if @filo_especie.update(filo_especie_params)
        format.html { redirect_to @filo_especie, notice: 'Filo especie was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_especie }
      else
        format.html { render :edit }
        format.json { render json: @filo_especie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_especies/1
  # DELETE /filo_especies/1.json
  def destroy
    @filo_especie.destroy
    respond_to do |format|
      format.html { redirect_to filo_especies_url, notice: 'Filo especie was successfully destroyed.' }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_especie
      @filo_especie = FiloEspecie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_especie_params
      params.require(:filo_especie).permit(:filo_especie, :nombre_comun, :iucn)
    end
end
