class Busqueda::IndEstructurasController < ApplicationController
  before_action :inicia_sesion
  before_action :set_ind_estructura, only: [:show, :edit, :update, :destroy, :procesa_estructura]

  include ProcesaEstructura

  # GET /ind_estructuras
  # GET /ind_estructuras.json
  def index
    set_tabla('ind_estructuras', IndEstructura.all.order(:ind_estructura), false)
    set_tabla('ind_sets', IndSet.all.order(:tipo), false)
#    @coleccion = {}
#    @coleccion['ind_estructuras'] = IndEstructura.all.order(:ind_estructura)

#    @coleccion['ind_sets']= IndSet.all.order(:tipo)
  end

  # GET /ind_estructuras/1
  # GET /ind_estructuras/1.json
  def show
    set_tabla('ind_modelos', @objeto.ind_modelos.order(:ind_modelos), false)
    set_tabla('ind_palabras', @objeto.ind_palabras.order(:ind_palabra), true)
  end

  # GET /ind_estructuras/new
  def new
    @objeto = IndEstructura.new
  end

  # GET /ind_estructuras/1/edit
  def edit
  end

  # POST /ind_estructuras
  # POST /ind_estructuras.json
  def create
    @objeto = IndEstructura.new(ind_estructura_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind estructura was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_estructuras/1
  # PATCH/PUT /ind_estructuras/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_estructura_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Ind estructura was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def procesa_estructura
    @objeto.ind_modelos.each do |ind_modelo|
      ind_modelo.ind_modelo.constantize.all.each do |objeto|
        if @objeto.ind_indices.where(class_name: objeto.class.name).where(objeto_id: objeto.id).empty?
          ind_modelo.campos.split(' ').each do |campo|
            procesa_campos_busqueda(@objeto, objeto, campo)
          end
        end
      end
    end
    redirect_to @objeto
  end

  # DELETE /ind_estructuras/1
  # DELETE /ind_estructuras/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Ind estructura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_estructura
      @objeto = IndEstructura.find(params[:id])
    end

    def set_redireccion
      @redireccion = ind_estructuras_path
    end

    # Only allow a list of trusted parameters through.
    def ind_estructura_params
      params.require(:ind_estructura).permit(:ind_estructura)
    end
end
