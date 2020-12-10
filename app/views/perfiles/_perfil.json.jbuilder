json.extract! perfil, :id, :usuario_id, :administrador_id, :investigador_id, :equipo_id, :created_at, :updated_at
json.url perfil_url(perfil, format: :json)
