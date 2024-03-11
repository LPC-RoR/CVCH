class Taxonomia::FiloInteraccionesController < ApplicationController
  before_action :set_filo_interaccion, only: [:show, :edit, :update, :destroy, :eliminar, :set_rol ]

  # GET /filo_interacciones
  # GET /filo_interacciones.json
  def index
    @coleccion = FiloInteraccion.all
  end

  # GET /filo_interacciones/1
  # GET /filo_interacciones/1.json
  def show
  end

  # GET /filo_interacciones/new
  def new
    @objeto = FiloInteraccion.new(publicacion_id: params[:pid])
  end

  # GET /filo_interacciones/1/edit
  def edit
  end

  # POST /filo_interacciones
  # POST /filo_interacciones.json
  def create
    @objeto = FiloInteraccion.new(filo_interaccion_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Interacción fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_interacciones/1
  # PATCH/PUT /filo_interacciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_interaccion_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Interacción fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def crea_interaccion
    publicacion = Publicacion.find(params[:pid])
    FiloInteraccion.create(filo_def_interaccion_id: params[:iid], publicacion_id: params[:pid])

    redirect_to publicacion, notice: 'Interacción fue creada exitósamente'
  end

  def eliminar
    publicacion = @objeto.publicacion
    @objeto.filo_roles.each do |fr|
      fr.delete
    end
    @objeto.delete

    redirect_to publicacion, notice: 'Interacción fue eliminada exitósamente'
  end

  def set_rol
    publicacion = @objeto.publicacion
    especie = Especie.find(params[:e_id])
    if especie.filo_especie.present?
      filo_especie = especie.filo_especie
      noticia = "#{params[:o].capitalize} rol fue ingresado exitósamente"
    elsif especie.filo_sinonimo.present?
      if especie.filo_sinonimo.filo_especies.count == 1
        filo_especie =  especie.filo_sinonimo.filo_especies.first
        noticia = "#{params[:o].capitalize} rol fue ingresado exitósamente para especie actualizada"
      else
        filo_especie = nil
        noticia = 'Error: Esta especie es sinónimo de más de una especie'
      end
    end
    unless filo_especie.blank?
      filo_rol = params[:o] == 'primer' ? @objeto.primer_def_rol.filo_def_rol : @objeto.segundo_def_rol.filo_def_rol
      FiloRol.create(filo_especie_id: filo_especie.id, filo_interaccion_id: @objeto.id, filo_rol: filo_rol)
    end

    redirect_to publicacion, notice: noticia
  end

  # DELETE /filo_interacciones/1
  # DELETE /filo_interacciones/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Interacción fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_interaccion
      @objeto = FiloInteraccion.find(params[:id])
    end

    def set_redireccion
      @redireccion = @objeto.publicacion
    end

    # Only allow a list of trusted parameters through.
    def filo_interaccion_params
      params.require(:filo_interaccion).permit(:filo_def_interaccion_id, :publicacion_id)
    end
end
