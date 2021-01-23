class PerfilesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :set_perfil, only: [:show, :edit, :update, :destroy]

  # GET /perfiles
  # GET /perfiles.json
  def index
    if session[:perfil_activo] == session[:perfil_base]
      @activo = Perfil.find(session[:perfil_activo]['id'])
      @coleccion = Perfil.where(id: @activo.equipos.map {|e| e.perfil.id})
    else
      @coleccion = Perfil.where(id: session[:perfil_base]['id'])
    end
  end

  # GET /perfiles/1
  # GET /perfiles/1.json
  def show
    session[:perfil_activo] = @objeto
    redirect_to '/perfiles'
  end

  # GET /perfiles/new
  def new
    @objeto = Perfil.new
  end

  # GET /perfiles/1/edit
  def edit
  end

  def inicia_sesion
    if usuario_signed_in?
      # Perro furioso
      @dog = Administrador.find_by(email: 'hugo.chinga.g@gmail.com')
      @dog = Administrador.create(administrador: 'Hugo Chinga G.', email: 'hugo.chinga.g@gmail.com') if @dog.blank?

      # En este minuto SIMULA que viene de la autenticacion con un usuario.email == 'hugo.chinga.g@gmail.com'
      # 1.- Verifica si Hay Perfil para ese correo
      @perfil = Perfil.find_by(email: current_usuario.email)
      @perfil = Perfil.create(email: current_usuario.email) if @perfil.blank?

      # 2.- Preguntamos SI ESTA EN LA LISTA DE ADMINISTRADORES, si ESTÁ se asegura de relacionarlo
      @administrador = Administrador.find_by(email: @perfil.email)
      # ACTUALIZO ADMINISTRADOR DEL PERFIL SI ES NECESARIO
      if @administrador.present? and @perfil.administrador.blank?
        @perfil.administrador = @administrador
        @perfil.save
      end

      # 3.- VERIFICA INVESTIGADOR
      @investigador = Investigador.find_by(email: @perfil.email)
      # 1.- SI Hay que crear el Investigador?
      if (@administrador.blank? and @perfil.investigador.blank? and @investigador.blank?)
        @investigador = Investigador.create(investigador: @perfil.email, email: @perfil.email)
        @perfil.investigador = @investigador
        @perfil.save
      end

      if @perfil.carpetas.empty?
        @perfil.carpetas.create(carpeta: 'Revisar')
        @perfil.carpetas.create(carpeta: 'Excluidas')
        @perfil.carpetas.create(carpeta: 'Postergadas')
        @perfil.carpetas.create(carpeta: 'Revisadas')
      end

      # Crea Directorios del ADMINISTRADORES
      Configuracion::CARGA_CONTROLLERS.each do |controlador|
        # formato directorios de carga : /eda/archivo/<email usuario>/<controlador>/
        # Por ahora consideramos UNA carga por controlador
        dir = File.dirname("#{Rails.root}#{Configuracion::RUTA_ARCHIVOS_ADMIN}#{controlador}/archivo")
        FileUtils.mkdir_p(dir) unless File.directory?(dir)
      end

      session[:perfil_base]      = @perfil
      session[:perfil_activo]    = @perfil
      session[:administrador]    = @perfil.administrador
      session[:es_administrador] = @perfil.administrador.present?
    end

    redirect_to vistas_path
    
  end

  # POST /perfiles
  # POST /perfiles.json
  def create
    @objeto = Perfil.new(perfil_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Perfil was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfiles/1
  # PATCH/PUT /perfiles/1.json
  def update
    respond_to do |format|
      if @objeto.update(perfil_params)
        format.html { redirect_to @objeto, notice: 'Perfil was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfiles/1
  # DELETE /perfiles/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to perfiles_url, notice: 'Perfil was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil
      @objeto = Perfil.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def perfil_params
      params.require(:perfil).permit(:usuario_id, :administrador_id, :investigador_id, :equipo_id)
    end
end
