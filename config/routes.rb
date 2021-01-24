Rails.application.routes.draw do
  resources :administradores
  resources :areas
  resources :ascendencias
  resources :autores
  resources :cargas do
#    match :procesa_carga, via: :get, on: :member
    match :procesa_carga, via: :get, on: :collection
    match :sel_archivo, via: :get, on: :collection
  end
  resources :carpetas do
    match :nuevo, via: :post, on: :collection
    match :seleccion, via: :get, on: :collection
  end
  resources :clasificaciones
  resources :departamentos do
    resources :investigadores
  end
  resources :conceptos do
    resources :instancias
  end
  resources :configuraciones
  resources :contribuciones
  resources :equipos do
    match :nuevo, via: :post, on: :collection
    match :elimina_equipo, via: :get, on: :member
  end
  resources :evaluaciones
  resources :idiomas do 
    resources :revistas
  end
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
  resources :perfiles do
      match :inicia_sesion, via: :get, on: :collection
  end
  resources :procesos
  resources :publicaciones do
    match :cambia_area, via: :get, on: :collection
    match :cambia_carpeta, via: :get, on: :collection
    match :cambia_evaluacion, via: :get, on: :collection
    match :cambia_tipo, via: :get, on: :collection
    match :estado, via: :get, on: :collection
  end
  resources :recursos do
    collection do
      match :tablas, via: :get
      match :manual, via: :get
    end
  end
  resources :registros do
    resources :publicaciones
  end
  resources :revisiones
  resources :rutas
  resources :revistas do
    resources :publicaciones
  end
  resources :vistas do
    match :escritorio, via: :get, on: :collection
    match :graficos, via: :get, on: :collection
  end

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'perfiles#inicia_sesion'

end
