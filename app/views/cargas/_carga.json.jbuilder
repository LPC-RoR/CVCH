json.extract! carga, :id, :archivo, :nota, :estado, :investigador_id, :created_at, :updated_at
json.url carga_url(carga, format: :json)
