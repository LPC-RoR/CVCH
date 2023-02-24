Rails.application.routes.draw do

  resources :filo_ele_eles
  resources :filo_elementos do
    match :nuevo, via: :post, on: :collection
    match :elimina, via: :get, on: :collection
  end
  resources :ind_sinonimos
  resources :esp_areas
  resources :per_equipos
  # SCOPE APLICACION
  scope module: 'aplicacion' do
    resources :app_administradores
    resources :app_nominas
    resources :app_perfiles do
      match :desvincular, via: :get, on: :member
    end
    resources :app_observaciones
    resources :app_mejoras

    resources :app_recursos do
      collection do
        match :ayuda, via: :get
        match :home, via: :get
        match :administracion, via: :get
        match :procesos, via: :get
      end
    end

    resources :app_imagenes
    
    resources :app_msg_msgs
    resources :app_mensajes

    resources :administradores
    resources :perfiles
    resources :observaciones
    resources :mejoras do
      match :nuevo, via: :post, on: :collection
    end
    resources :recursos do
      collection do
        match :ayuda, via: :get
        match :home, via: :get
        match :administracion, via: :get
        match :procesos, via: :get
      end
    end
  end

  scope module: 'home' do
    resources :h_imagenes
    resources :h_links
    resources :h_temas
    end
  
  scope module: 'sidebar' do
    resources :sb_elementos
    resources :sb_listas do
      resources :sb_elementos
    end
  end


  # SCOPE HELP
  scope module: 'help' do
    resources :hlp_pasos
    resources :hlp_tutoriales do
      resources :hlp_pasos
    end

#    resources :conversaciones
    resources :mensajes do 
      match :estado, via: :get, on: :member
      match :respuesta, via: :post, on: :collection
    end
    resources :pasos
    resources :tema_ayudas do
      resources :tutoriales
    end
    resources :tutoriales do
      resources :pasos
    end
  end

  scope module: 'busqueda' do
    # Estructura de búsqueda
    resources :ind_estructuras do
      resources :ind_modelos
      match :procesa_estructura, via: :get, on: :member
    end
    # Modelos asociados a una estructura, se pueden indexar muchos modelos es un mismo índice.
    resources :ind_modelos

    # El buscador opera según estos valores
    resources :ind_palabras
    resources :ind_claves
    resources :ind_indices

    ## GRAMATICA del buscados
    resources :ind_sets

    resources :ind_bases
    resources :ind_direcciones
    resources :ind_lenguajes
    resources :ind_redacciones
    resources :ind_expresiones
  end

  resources :etiquetas
  resources :suscripciones
  resources :relaciones
  resources :areas do 
    match :asigna, via: :get, on: :member
    match :desasignar, via: :get, on: :member
  end
  resources :ascendencias
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
    match :sel_archivo, via: :get, on: :collection
  end
  resources :carpetas do
    match :nuevo, via: :post, on: :collection
    match :seleccion, via: :get, on: :collection
    match :asigna, via: :get, on: :member
    match :desasignar, via: :get, on: :member
  end
  resources :clasificaciones
  resources :categorias do
    match :asigna, via: :get, on: :member
    match :desasignar, via: :get, on: :member
    match :aceptar, via: :get, on: :member
    match :rechazar, via: :get, on: :member
  end
  resources :departamentos do
    resources :investigadores
  end
  resources :conceptos do
    resources :instancias
  end
  resources :contribuciones
  resources :diccionarios
  resources :equipos do
    match :nuevo, via: :post, on: :collection
    match :participa, via: :post, on: :collection
    match :nueva_carpeta_equipo, via: :post, on: :collection
  end
  resources :especies do
    match :asigna, via: :post, on: :collection
    match :desasignar, via: :get, on: :member
    match :aceptar, via: :get, on: :member
    match :rechazar, via: :get, on: :member
  end
  resources :evaluaciones
  resources :idiomas do 
    resources :revistas
  end
  resources :herencias
  resources :integrantes
  resources :instancias do
    match :nuevo, via: :post, on: :collection
    match :elimina_instancia, via: :get, on: :member
  end
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores do
    match :perfil, via: :get, on: :member
  end
  resources :pasos
  resources :procesos
  resources :propuestas do
    match :elimina_propuesta, via: :get, on: :member
  end
  resources :publicaciones do
    match :cambia_evaluacion, via: :get, on: :member
    match :cambia_tipo, via: :get, on: :collection
    match :estado, via: :get, on: :collection
  end
  resources :registros do
    resources :publicaciones
  end
  resources :revisiones
  resources :rutas do
    match :elimina_ruta, via: :get, on: :member
  end
  resources :revistas do
    resources :publicaciones
  end
  resources :vistas do
    match :escritorio, via: :get, on: :collection
    match :graficos, via: :get, on: :collection
  end

  devise_for :usuarios, controllers: {
        confirmations: 'usuarios/confirmations',
#        omniauth_callbacks: 'usuarios/omniauth_callbacks',
        passwords: 'usuarios/passwords',
        registrations: 'usuarios/registrations',
        sessions: 'usuarios/sessions',
        unlocks: 'usuarios/unlocks'
      }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'aplicacion/app_recursos#home'

end
