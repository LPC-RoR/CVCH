Rails.application.routes.draw do

  # SCOPE APLICACION
  scope module: 'aplicacion' do
    resources :administradores
    resources :perfiles
    resources :observaciones
    resources :mejoras do
      match :nuevo, via: :post, on: :collection
    end
    resources :recursos do
      collection do
        match :home, via: :get
        match :archivos, via: :get
      end
    end
  end

  # SCOPE HELP
  scope module: 'help' do
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
    resources :ind_indices
    resources :ind_bases
    resources :ind_direcciones
    resources :ind_claves
    resources :ind_palabras
    resources :ind_lenguajes
  end

  resources :etiquetas
  resources :suscripciones
  resources :relaciones
  resources :areas do 
    match :asigna, via: :post, on: :collection
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
    match :asigna, via: :post, on: :collection
    match :desasignar, via: :get, on: :member
  end
  resources :clasificaciones
  resources :categorias do
    match :asigna, via: :post, on: :collection
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
  resources :configuraciones
  resources :contribuciones
  resources :diccionarios
  resources :equipos do
    match :nuevo, via: :post, on: :collection
    match :nueva_carpeta_equipo, via: :post, on: :collection

    match :elimina_equipo, via: :get, on: :member
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

  root 'aplicacion/recursos#home'

end
