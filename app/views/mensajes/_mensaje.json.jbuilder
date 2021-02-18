json.extract! mensaje, :id, :mensaje, :tipo, :estado, :email, :fecha_envio, :detalle, :perfil_id, :created_at, :updated_at
json.url mensaje_url(mensaje, format: :json)
