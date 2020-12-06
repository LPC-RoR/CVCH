Rails.application.routes.draw do
  resources :areas
  resources :ascendencias
  resources :autores
  resources :cargas do
    match :procesa_carga, via: :get, on: :member
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
  end
  resources :evaluaciones
  resources :idiomas do 
    resources :revistas
  end
  resources :integrantes
  resources :instancias
  resources :instituciones do
    resources :departamentos
    resources :registros
  end
  resources :investigadores do
    match :perfil, via: :get, on: :member
  end
  resources :procesos
  resources :publicaciones do
    match :mask_new, via: :get, on: :collection
    match :mask_nuevo, via: :post, on: :collection
    match :cambia_area, via: :get, on: :collection
    match :cambia_carpeta, via: :get, on: :collection
    match :cambia_evaluacion, via: :get, on: :collection
    match :cambia_tipo, via: :get, on: :collection
    match :estado, via: :get, on: :collection
  end
  resources :recursos do
    collection do
      match :inicia_sesion, via: :get
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
  end

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recursos#inicia_sesion'

end
