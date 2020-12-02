class RecursosController < ApplicationController
#  before_action :set_recurso, only: [:show, :edit, :update, :destroy]

  def inicia_sesion
    @i_perfil = Investigador.find_by(investigador: 'Hugo, Chinga')
    if @i_perfil.blank?
      @i_perfil = Investigador.create(investigador: 'Hugo, Chinga', email: 'hugo.chinga.g@gmail.com')
      @i_perfil.carpetas.create(carpeta: 'Revisar')
      @i_perfil.carpetas.create(carpeta: 'Excluidas')
      @i_perfil.carpetas.create(carpeta: 'Postergadas')
      @i_perfil.carpetas.create(carpeta: 'Revisadas')

      # Crea Directorios del Usuario
      Configuracion::CARGA_CONTROLLERS.each do |controlador|
        # formato directorios de carga : /eda/archivo/<email usuario>/<controlador>/
        # Por ahora consideramos UNA carga por controlador
        dir = File.dirname("#{Rails.root}/archivos/admin/#{controlador}/archivo")
        FileUtils.mkdir_p(dir) unless File.directory?(dir)
      end
    end

    session[:perfil] = @i_perfil

    redirect_to "/investigadores/#{@i_perfil.id}/perfil"
    
  end

  # GET /recursos/tablas
  def tablas
    @ftab = params[:ftab].blank? ? Configuracion::RECURSO_ACTIONS_TABS[action_name][0] : params[:ftab]
    @estado = params[:estado].blank? ? @ftab.classify.constantize::ESTADOS[0] : params[:estado]
    # Manejo de Tablas, Tabs y Estados
#    @coleccion = @ftab.classify.constantize::all.where(estado: @estado)
    @coleccion = @ftab.classify.constantize::all
  end

  def manual
    @ftab = 'publicaciones'
#    @ftab = params[:ftab].blank? ? Configuracion::RECURSO_ACTIONS_TABS[action_name][0] : params[:ftab]
#    @estado = params[:estado].blank? ? @ftab.classify.constantize::ESTADOS[0] : params[:estado]
    @coleccion = Publicacion.where(origen: 'Manual').page(params[:page])
  end


  private

end
