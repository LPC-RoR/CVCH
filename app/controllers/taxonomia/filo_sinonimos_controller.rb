class Taxonomia::FiloSinonimosController < ApplicationController
  before_action :set_filo_sinonimo, only: [:show, :edit, :update, :destroy, :set_sinonimo, :borrar]

  # GET /filo_sinonimos
  # GET /filo_sinonimos.json
  def index
    @coleccion = FiloSinonimo.all
  end

  # GET /filo_sinonimos/1
  # GET /filo_sinonimos/1.json
  def show
  end

  # GET /filo_sinonimos/new
  def new
    @objeto = FiloSinonimo.new
  end

  # GET /filo_sinonimos/1/edit
  def edit
  end

  # POST /filo_sinonimos
  # POST /filo_sinonimos.json
  def create
    @objeto = FiloSinonimo.new(filo_sinonimo_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Sinónimo fue exitósamente creado.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_sinonimos/1
  # PATCH/PUT /filo_sinonimos/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_sinonimo_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Sinónimo fue exitósamente actualizado.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_sinonimo
    filo_especie = FiloEspecie.find(params[:indice])
    unless params[:set_sinonimo][:tipo].blank?
      fes = filo_especie.filo_esp_sinos.find_by(filo_sinonimo_id: @objeto.id)
      fes.tipo = params[:set_sinonimo][:tipo]
      fes.save
    end
    if params[:set_sinonimo][:borrar] == '1'
      @objeto.correccion = nil
      @objeto.save
    else
      unless params[:set_sinonimo][:correccion].blank?
        unless params[:set_sinonimo][:correccion] == @objeto.correccion
          @objeto.correccion = params[:set_sinonimo][:correccion]
          @objeto.save
        end
      end
    end
    if @objeto.especie.present? and (@objeto.especie.especie != @objeto.filo_sinonimo)
      e=@objeto.especie
      e.filo_sinonimo_id = nil
      e.save
    end
    unless @objeto.especie.present?
      e=Especie.find_by(especie: @objeto.correccion)
      @objeto.especie = e unless e.blank?
    end

    redirect_to "/publicos/especies?indice=#{filo_especie.id}"
  end

  # DELETE /filo_sinonimos/1
  # DELETE /filo_sinonimos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Sinónimo fue exitósamente eliminado.' }
      format.json { head :no_content }
    end
  end

  def borrar
    filo_especie = FiloEspecie.find(params[:indice])
    filo_especie.filo_sinonimos.delete(@objeto)
    @objeto.delete

    redirect_to "/publicos/especies?indice=#{filo_especie.id}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_sinonimo
      @objeto = FiloSinonimo.find(params[:id])
    end

    def set_redireccion
      # NO SIRVE porque es @objeto.filo_especies !!
      @redireccion = "/publicos/especies?indice=#{@objeto.filo_especie.id}"
    end

    # Only allow a list of trusted parameters through.
    def filo_sinonimo_params
      params.require(:filo_sinonimo).permit(:filo_especie_id, :filo_sinonimo, :tipo)
    end
end
