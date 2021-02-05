Rails.application.routes.draw do
  resources :herencias
  resources :administradores
  resources :areas do 
    match :asigna, via: :post, on: :collection
    match :elimina_area, via: :get, on: :member
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
    match :elimina_carpeta, via: :get, on: :member
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
    match :nueva_carpeta_equipo, via: :post, on: :collection

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
  resources :perfiles
  resources :procesos
  resources :publicaciones do
    match :cambia_evaluacion, via: :get, on: :member
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

  root 'vistas#index'

end
