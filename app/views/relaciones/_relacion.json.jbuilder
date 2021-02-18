json.extract! relacion, :id, :parent_id, :child_id, :created_at, :updated_at
json.url relacion_url(relacion, format: :json)
