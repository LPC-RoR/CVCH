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
    @objeto = FiloInteraccion.new
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
        format.html { redirect_to @objeto, notice: 'Filo interaccion was successfully created.' }
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
        format.html { redirect_to @objeto, notice: 'Filo interaccion was successfully updated.' }
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
    filo_especie = especie.filo_especie
    filo_rol = params[:o] == 'primer' ? @objeto.primer_def_rol.filo_def_rol : @objeto.segundo_def_rol.filo_def_rol

    FiloRol.create(filo_especie_id: filo_especie.id, filo_interaccion_id: @objeto.id, filo_rol: filo_rol)

    redirect_to publicacion, notice: "#{params[:o].capitalize} rol fue ingresado exitósamente"
  end

  # DELETE /filo_interacciones/1
  # DELETE /filo_interacciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to filo_interacciones_url, notice: 'Filo interaccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_interaccion
      @objeto = FiloInteraccion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_interaccion_params
      params.require(:filo_interaccion).permit(:filo_def_interaccion_id, :publicacion_id)
    end
end
