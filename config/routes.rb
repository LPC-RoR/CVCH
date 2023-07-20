Rails.application.routes.draw do

  resources :car_filo_esps
  resources :filo_esp_esp_sinonimos
  resources :per_cares
  resources :filo_ordenes
  resources :filo_esp_esps
  resources :filo_especies do
    match :nuevo, via: :post, on: :collection
    match :nuevo_child, via: :post, on: :collection
    match :elimina, via: :get, on: :collection
    # nueva implementacion, verificar anteriores
    match :nueva_subespecie, via: :post, on: :collection
    match :nuevo_sinonimo, via: :post, on: :collection
    match :asocia_etiqueta, via: :post, on: :collection
    match :asigna, via: :post, on: :collection
  end
  resources :ind_exp_pales
  resources :filo_ele_eles
  resources :filo_elementos do
    resources :filo_especies
    match :nuevo, via: :post, on: :collection
    match :asigna_especie, via: :post, on: :collection
    match :elimina, via: :get, on: :collection
    match :elimina_base, via: :get, on: :collection
    match :asigna_area, via: :post, on: :collection
    match :libera_area, via: :get, on: :member
    # última implementación, revisar anteriores
    match :cambio_padre, via: :post, on: :collection
    match :nuevo_hijo, via: :post, on: :collection
  end
  resources :ind_sinonimos
  resources :esp_areas
  resources :per_equipos

# SCOPES *********************************************************
  scope module: 'autenticacion' do
    resources :app_administradores
    resources :app_nominas
    resources :app_perfiles do
      # recurso SOLO si hay manejo de ESTADOS
#      resources :st_perfil_modelos
    end
  end

  scope module: 'recursos' do
    resources :app_contactos
    resources :app_enlaces
    resources :app_mejoras
    resources :app_mensajes do
      match :respuesta, via: :post, on: :collection
      match :estado, via: :get, on: :member
    end
    resources :app_msg_msgs
    resources :app_observaciones
  end

  scope module: 'repositorios' do
#    resources :app_repos do
#      match :publico, via: :get, on: :collection
#      match :perfil, via: :get, on: :collection
#    end
#    resources :app_directorios do
#      match :nuevo, via: :post, on: :collection
#    end
#    resources :app_dir_dires
#    resources :app_documentos
#    resources :app_archivos
    resources :app_imagenes
  end

  scope module: 'aplicacion' do
    resources :publicos do
        match :home, via: :get, on: :collection
    end
    resources :app_recursos do
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
    resources :sb_elementos do
      match :arriba, via: :get, on: :member
      match :abajo, via: :get, on: :member
    end
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
    # Las ideas del buscador son los textos separados por punto ('.')
    resources :ind_ideas
    # has_many_through Ideas Expresiones
    resources :ind_ide_exps
    # Modelos asociados a una estructura, se pueden indexar muchos modelos es un mismo índice.
    resources :ind_modelos

    # El buscador opera según estos valores
    resources :ind_palabras do
      match :reprocesar, via: :get, on: :member
    end
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
    resources :filo_elementos
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
    # nueva version, revisar lo anterior
    match :compartir_carpeta, via: :post, on: :collection
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
    match :libera_especie, via: :get, on: :member
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
    match :graficos, via: :get, on: :collection
  end

  scope module: 'blog' do
    resources :blg_articulos
    resources :blg_temas
    resources :blg_imagenes
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

  root 'aplicacion/publicos#home'

end
