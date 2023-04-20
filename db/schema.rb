# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_04_20_005513) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administradores", force: :cascade do |t|
    t.string "administrador"
    t.string "email"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_administradores_on_email"
    t.index ["usuario_id"], name: "index_administradores_on_usuario_id"
  end

  create_table "app_administradores", force: :cascade do |t|
    t.string "administrador"
    t.string "email"
    t.integer "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_app_administradores_on_email"
    t.index ["usuario_id"], name: "index_app_administradores_on_usuario_id"
  end

  create_table "app_imagenes", force: :cascade do |t|
    t.string "nombre"
    t.string "imagen"
    t.string "credito_imagen"
    t.string "owner_class"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_app_imagenes_on_nombre"
    t.index ["owner_id"], name: "index_app_imagenes_on_owner_id"
  end

  create_table "app_mejoras", force: :cascade do |t|
    t.text "detalle"
    t.string "estado"
    t.string "owner_class"
    t.integer "owner_id"
    t.integer "app_perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_perfil_id"], name: "index_app_mejoras_on_app_perfil_id"
    t.index ["estado"], name: "index_app_mejoras_on_estado"
    t.index ["owner_class"], name: "index_app_mejoras_on_owner_class"
    t.index ["owner_id"], name: "index_app_mejoras_on_owner_id"
  end

  create_table "app_mensajes", force: :cascade do |t|
    t.string "mensaje"
    t.string "tipo"
    t.string "estado"
    t.string "email"
    t.datetime "fecha_envio"
    t.text "detalle"
    t.integer "app_perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_perfil_id"], name: "index_app_mensajes_on_app_perfil_id"
    t.index ["email"], name: "index_app_mensajes_on_email"
    t.index ["estado"], name: "index_app_mensajes_on_estado"
    t.index ["fecha_envio"], name: "index_app_mensajes_on_fecha_envio"
    t.index ["tipo"], name: "index_app_mensajes_on_tipo"
  end

  create_table "app_msg_msgs", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_app_msg_msgs_on_child_id"
    t.index ["parent_id"], name: "index_app_msg_msgs_on_parent_id"
  end

  create_table "app_nominas", force: :cascade do |t|
    t.string "nombre"
    t.string "email"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_app_nominas_on_email"
  end

  create_table "app_observaciones", force: :cascade do |t|
    t.text "detalle"
    t.string "owner_class"
    t.integer "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "app_perfil_id"
    t.index ["app_perfil_id"], name: "index_app_observaciones_on_app_perfil_id"
    t.index ["owner_class"], name: "index_app_observaciones_on_owner_class"
    t.index ["owner_id"], name: "index_app_observaciones_on_owner_id"
  end

  create_table "app_perfiles", force: :cascade do |t|
    t.string "email"
    t.integer "usuario_id"
    t.integer "app_administrador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_administrador_id"], name: "index_app_perfiles_on_app_administrador_id"
    t.index ["email"], name: "index_app_perfiles_on_email"
    t.index ["usuario_id"], name: "index_app_perfiles_on_usuario_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "area"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area"], name: "index_areas_on_area"
  end

  create_table "ascendencias", force: :cascade do |t|
    t.integer "padre_id"
    t.integer "hijo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hijo_id"], name: "index_ascendencias_on_hijo_id"
    t.index ["padre_id"], name: "index_ascendencias_on_padre_id"
  end

  create_table "autores", force: :cascade do |t|
    t.integer "investigador_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investigador_id"], name: "index_autores_on_investigador_id"
    t.index ["publicacion_id"], name: "index_autores_on_publicacion_id"
  end

  create_table "cargas", force: :cascade do |t|
    t.string "archivo"
    t.string "nota"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.string "status"
    t.integer "n_procesados"
    t.integer "n_carga"
    t.integer "n_duplicados"
    t.integer "perfil_id"
    t.integer "n_formatos"
    t.integer "n_publicadas"
    t.integer "n_areas"
    t.string "archivo_carga"
    t.integer "app_perfil_id"
    t.index ["app_perfil_id"], name: "index_cargas_on_app_perfil_id"
    t.index ["area_id"], name: "index_cargas_on_area_id"
    t.index ["perfil_id"], name: "index_cargas_on_perfil_id"
  end

  create_table "carpetas", force: :cascade do |t|
    t.string "carpeta"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.integer "app_perfil_id"
    t.string "sha1"
    t.index ["app_perfil_id"], name: "index_carpetas_on_app_perfil_id"
    t.index ["carpeta"], name: "index_carpetas_on_carpeta"
    t.index ["perfil_id"], name: "index_carpetas_on_perfil_id"
    t.index ["sha1"], name: "index_carpetas_on_sha1"
  end

  create_table "categorias", force: :cascade do |t|
    t.string "categoria"
    t.integer "perfil_id"
    t.boolean "base"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "aceptado"
    t.index ["base"], name: "index_categorias_on_base"
    t.index ["categoria"], name: "index_categorias_on_categoria"
    t.index ["perfil_id"], name: "index_categorias_on_perfil_id"
  end

  create_table "clasificaciones", force: :cascade do |t|
    t.integer "carpeta_id"
    t.integer "publicacion_id"
    t.integer "paper_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.index ["area_id"], name: "index_clasificaciones_on_area_id"
    t.index ["carpeta_id"], name: "index_clasificaciones_on_carpeta_id"
    t.index ["paper_id"], name: "index_clasificaciones_on_paper_id"
    t.index ["publicacion_id"], name: "index_clasificaciones_on_publicacion_id"
  end

  create_table "conceptos", force: :cascade do |t|
    t.string "concepto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.boolean "administracion"
    t.index ["administracion"], name: "index_conceptos_on_administracion"
    t.index ["concepto"], name: "index_conceptos_on_concepto"
    t.index ["perfil_id"], name: "index_conceptos_on_perfil_id"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "departamento"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institucion_id"], name: "index_departamentos_on_institucion_id"
  end

  create_table "diccionarios", force: :cascade do |t|
    t.integer "concepto_id"
    t.integer "instancia_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concepto_id"], name: "index_diccionarios_on_concepto_id"
    t.index ["instancia_id"], name: "index_diccionarios_on_instancia_id"
  end

  create_table "equipos", force: :cascade do |t|
    t.string "equipo"
    t.string "sha1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "administrador_id"
    t.integer "app_administrador_id"
    t.index ["administrador_id"], name: "index_equipos_on_administrador_id"
    t.index ["app_administrador_id"], name: "index_equipos_on_app_administrador_id"
    t.index ["equipo"], name: "index_equipos_on_equipo"
    t.index ["sha1"], name: "index_equipos_on_sha1"
  end

  create_table "esp_areas", force: :cascade do |t|
    t.integer "especie_id"
    t.integer "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_esp_areas_on_area_id"
    t.index ["especie_id"], name: "index_esp_areas_on_especie_id"
  end

  create_table "especies", force: :cascade do |t|
    t.string "especie"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "filo_elemento_id"
    t.integer "filo_especie_id"
    t.index ["especie"], name: "index_especies_on_especie"
    t.index ["filo_elemento_id"], name: "index_especies_on_filo_elemento_id"
    t.index ["filo_especie_id"], name: "index_especies_on_filo_especie_id"
  end

  create_table "etiquetas", force: :cascade do |t|
    t.integer "categoria_id"
    t.integer "publicacion_id"
    t.integer "especie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "revisado"
    t.integer "asociado_por"
    t.index ["categoria_id"], name: "index_etiquetas_on_categoria_id"
    t.index ["especie_id"], name: "index_etiquetas_on_especie_id"
    t.index ["publicacion_id"], name: "index_etiquetas_on_publicacion_id"
  end

  create_table "evaluaciones", force: :cascade do |t|
    t.string "aspecto"
    t.string "evaluacion"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["aspecto"], name: "index_evaluaciones_on_aspecto"
    t.index ["perfil_id"], name: "index_evaluaciones_on_perfil_id"
    t.index ["publicacion_id"], name: "index_evaluaciones_on_publicacion_id"
  end

  create_table "filo_ele_eles", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_filo_ele_eles_on_child_id"
    t.index ["parent_id"], name: "index_filo_ele_eles_on_parent_id"
  end

  create_table "filo_elementos", force: :cascade do |t|
    t.string "filo_elemento"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descripcion"
    t.integer "filo_orden_id"
    t.integer "area_id"
    t.index ["area_id"], name: "index_filo_elementos_on_area_id"
    t.index ["filo_elemento"], name: "index_filo_elementos_on_filo_elemento"
    t.index ["filo_orden_id"], name: "index_filo_elementos_on_filo_orden_id"
  end

  create_table "filo_esp_esps", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_filo_esp_esps_on_child_id"
    t.index ["parent_id"], name: "index_filo_esp_esps_on_parent_id"
  end

  create_table "filo_especies", force: :cascade do |t|
    t.string "filo_especie"
    t.string "nombre_comun"
    t.string "iucn"
    t.integer "filo_elemento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "especie_id"
    t.index ["especie_id"], name: "index_filo_especies_on_especie_id"
    t.index ["filo_elemento_id"], name: "index_filo_especies_on_filo_elemento_id"
    t.index ["filo_especie"], name: "index_filo_especies_on_filo_especie"
  end

  create_table "filo_ordenes", force: :cascade do |t|
    t.integer "orden"
    t.string "filo_orden"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filo_orden"], name: "index_filo_ordenes_on_filo_orden"
  end

  create_table "h_imagenes", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_h_imagenes_on_nombre"
  end

  create_table "h_links", force: :cascade do |t|
    t.string "texto"
    t.string "link"
    t.string "owner_class"
    t.string "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "h_portadas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "portada"
    t.index ["portada"], name: "index_h_portadas_on_portada"
  end

  create_table "h_temas", force: :cascade do |t|
    t.string "tema"
    t.string "detalle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tema"], name: "index_h_temas_on_tema"
  end

  create_table "herencias", force: :cascade do |t|
    t.integer "equipo_id"
    t.integer "carpeta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpeta_id"], name: "index_herencias_on_carpeta_id"
    t.index ["equipo_id"], name: "index_herencias_on_equipo_id"
  end

  create_table "hlp_pasos", force: :cascade do |t|
    t.integer "orden"
    t.string "paso"
    t.text "detalle"
    t.integer "hlp_tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hlp_tutorial_id"], name: "index_hlp_pasos_on_hlp_tutorial_id"
    t.index ["orden"], name: "index_hlp_pasos_on_orden"
  end

  create_table "hlp_tutoriales", force: :cascade do |t|
    t.string "tutorial"
    t.string "clave"
    t.text "detalle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clave"], name: "index_hlp_tutoriales_on_clave"
  end

  create_table "idiomas", force: :cascade do |t|
    t.string "idioma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma"], name: "index_idiomas_on_idioma"
  end

  create_table "ind_bases", force: :cascade do |t|
    t.integer "clave_id"
    t.integer "ind_palabra_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clave_id"], name: "index_ind_bases_on_clave_id"
    t.index ["ind_palabra_id"], name: "index_ind_bases_on_ind_palabra_id"
  end

  create_table "ind_claves", force: :cascade do |t|
    t.string "ind_clave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ind_estructura_id"
    t.index ["ind_clave"], name: "index_ind_claves_on_ind_clave"
    t.index ["ind_estructura_id"], name: "index_ind_claves_on_ind_estructura_id"
  end

  create_table "ind_direcciones", force: :cascade do |t|
    t.integer "origen_id"
    t.integer "destino_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destino_id"], name: "index_ind_direcciones_on_destino_id"
    t.index ["origen_id"], name: "index_ind_direcciones_on_origen_id"
  end

  create_table "ind_estructuras", force: :cascade do |t|
    t.string "ind_estructura"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ind_exp_pales", force: :cascade do |t|
    t.integer "ind_expresion_id"
    t.integer "ind_palabra_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_expresion_id"], name: "index_ind_exp_pales_on_ind_expresion_id"
    t.index ["ind_palabra_id"], name: "index_ind_exp_pales_on_ind_palabra_id"
  end

  create_table "ind_expresiones", force: :cascade do |t|
    t.string "ind_expresion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ind_estructura_id"
    t.index ["ind_estructura_id"], name: "index_ind_expresiones_on_ind_estructura_id"
  end

  create_table "ind_ide_exps", force: :cascade do |t|
    t.integer "ind_idea_id"
    t.integer "ind_expresion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_expresion_id"], name: "index_ind_ide_exps_on_ind_expresion_id"
    t.index ["ind_idea_id"], name: "index_ind_ide_exps_on_ind_idea_id"
  end

  create_table "ind_ideas", force: :cascade do |t|
    t.integer "ind_estructura_id"
    t.string "ind_idea"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_estructura_id"], name: "index_ind_ideas_on_ind_estructura_id"
    t.index ["ind_idea"], name: "index_ind_ideas_on_ind_idea"
  end

  create_table "ind_indices", force: :cascade do |t|
    t.integer "ind_clave_id"
    t.string "class_name"
    t.integer "objeto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ind_estructura_id"
    t.integer "ind_palabra_id"
    t.index ["class_name"], name: "index_ind_indices_on_class_name"
    t.index ["ind_clave_id"], name: "index_ind_indices_on_ind_clave_id"
    t.index ["ind_estructura_id"], name: "index_ind_indices_on_ind_estructura_id"
    t.index ["ind_palabra_id"], name: "index_ind_indices_on_ind_palabra_id"
    t.index ["objeto_id"], name: "index_ind_indices_on_objeto_id"
  end

  create_table "ind_lenguajes", force: :cascade do |t|
    t.string "ind_lenguaje"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_lenguaje"], name: "index_ind_lenguajes_on_ind_lenguaje"
  end

  create_table "ind_modelos", force: :cascade do |t|
    t.string "ind_modelo"
    t.string "campos"
    t.integer "ind_estructura_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_estructura_id"], name: "index_ind_modelos_on_ind_estructura_id"
  end

  create_table "ind_palabras", force: :cascade do |t|
    t.string "ind_palabra"
    t.integer "ind_lenguaje_id"
    t.integer "ind_clave_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ind_estructura_id"
    t.integer "ind_sinonimo_id"
    t.index ["ind_clave_id"], name: "index_ind_palabras_on_ind_clave_id"
    t.index ["ind_estructura_id"], name: "index_ind_palabras_on_ind_estructura_id"
    t.index ["ind_lenguaje_id"], name: "index_ind_palabras_on_ind_lenguaje_id"
    t.index ["ind_palabra"], name: "index_ind_palabras_on_ind_palabra"
    t.index ["ind_sinonimo_id"], name: "index_ind_palabras_on_ind_sinonimo_id"
  end

  create_table "ind_redacciones", force: :cascade do |t|
    t.integer "ind_palabra_id"
    t.integer "ind_expresion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_expresion_id"], name: "index_ind_redacciones_on_ind_expresion_id"
    t.index ["ind_palabra_id"], name: "index_ind_redacciones_on_ind_palabra_id"
  end

  create_table "ind_sets", force: :cascade do |t|
    t.string "ind_set"
    t.string "tipo"
    t.text "set"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_set"], name: "index_ind_sets_on_ind_set"
    t.index ["tipo"], name: "index_ind_sets_on_tipo"
  end

  create_table "ind_sinonimos", force: :cascade do |t|
    t.string "ind_sinonimo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ind_sinonimo"], name: "index_ind_sinonimos_on_ind_sinonimo"
  end

  create_table "instancias", force: :cascade do |t|
    t.string "instancia"
    t.string "sha1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sha1"], name: "index_instancias_on_sha1"
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "institucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "integrantes", force: :cascade do |t|
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["equipo_id"], name: "index_integrantes_on_equipo_id"
    t.index ["perfil_id"], name: "index_integrantes_on_perfil_id"
  end

  create_table "investigadores", force: :cascade do |t|
    t.string "investigador"
    t.string "orcid"
    t.string "email"
    t.integer "departamento_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["departamento_id"], name: "index_investigadores_on_departamento_id"
    t.index ["investigador"], name: "index_investigadores_on_investigador"
  end

  create_table "mejoras", force: :cascade do |t|
    t.string "mejora"
    t.text "detalle"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["publicacion_id"], name: "index_mejoras_on_publicacion_id"
  end

  create_table "mensajes", force: :cascade do |t|
    t.string "mensaje"
    t.string "tipo"
    t.string "estado"
    t.string "email"
    t.datetime "fecha_envio"
    t.text "detalle"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mensajes_on_email"
    t.index ["estado"], name: "index_mensajes_on_estado"
    t.index ["fecha_envio"], name: "index_mensajes_on_fecha_envio"
    t.index ["perfil_id"], name: "index_mensajes_on_perfil_id"
    t.index ["tipo"], name: "index_mensajes_on_tipo"
  end

  create_table "observaciones", force: :cascade do |t|
    t.string "observacion"
    t.text "detalle"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["publicacion_id"], name: "index_observaciones_on_publicacion_id"
  end

  create_table "pasos", force: :cascade do |t|
    t.integer "orden"
    t.string "paso"
    t.text "detalle"
    t.integer "tutorial_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_pasos_on_orden"
    t.index ["tutorial_id"], name: "index_pasos_on_tutorial_id"
  end

  create_table "per_cares", force: :cascade do |t|
    t.integer "app_perfil_id"
    t.integer "carpeta_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_perfil_id"], name: "index_per_cares_on_app_perfil_id"
    t.index ["carpeta_id"], name: "index_per_cares_on_carpeta_id"
  end

  create_table "per_equipos", force: :cascade do |t|
    t.integer "app_perfil_id"
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_perfil_id"], name: "index_per_equipos_on_app_perfil_id"
    t.index ["equipo_id"], name: "index_per_equipos_on_equipo_id"
  end

  create_table "perfiles", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "administrador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["administrador_id"], name: "index_perfiles_on_administrador_id"
    t.index ["email"], name: "index_perfiles_on_email"
    t.index ["usuario_id"], name: "index_perfiles_on_usuario_id"
  end

  create_table "procesos", force: :cascade do |t|
    t.integer "carga_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carga_id"], name: "index_procesos_on_carga_id"
    t.index ["publicacion_id"], name: "index_procesos_on_publicacion_id"
  end

  create_table "propuestas", force: :cascade do |t|
    t.integer "instancia_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["instancia_id"], name: "index_propuestas_on_instancia_id"
    t.index ["perfil_id"], name: "index_propuestas_on_perfil_id"
    t.index ["publicacion_id"], name: "index_propuestas_on_publicacion_id"
  end

  create_table "publicaciones", force: :cascade do |t|
    t.string "unique_id"
    t.string "origen"
    t.string "title"
    t.string "author"
    t.string "doi"
    t.string "year"
    t.string "volume"
    t.string "pages"
    t.string "month"
    t.string "publisher"
    t.string "abstract"
    t.string "link"
    t.string "author_email"
    t.string "issn"
    t.string "eissn"
    t.string "address"
    t.string "affiliation"
    t.string "article_number"
    t.string "keywords"
    t.string "keywords_plus"
    t.string "research_areas"
    t.string "web_of_science_categories"
    t.string "da"
    t.string "d_journal"
    t.string "d_author"
    t.string "d_doi"
    t.integer "registro_id"
    t.integer "revista_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "d_quote"
    t.string "doc_type"
    t.string "estado"
    t.string "academic_degree"
    t.string "book"
    t.string "t_sha1"
    t.string "unicidad"
    t.integer "perfil_id"
    t.string "editor"
    t.string "ciudad_pais"
    t.string "journal"
    t.integer "app_perfil_id"
    t.index ["app_perfil_id"], name: "index_publicaciones_on_app_perfil_id"
    t.index ["doc_type"], name: "index_publicaciones_on_doc_type"
    t.index ["estado"], name: "index_publicaciones_on_estado"
    t.index ["origen"], name: "index_publicaciones_on_origen"
    t.index ["perfil_id"], name: "index_publicaciones_on_perfil_id"
    t.index ["registro_id"], name: "index_publicaciones_on_registro_id"
    t.index ["revista_id"], name: "index_publicaciones_on_revista_id"
    t.index ["t_sha1"], name: "index_publicaciones_on_t_sha1"
    t.index ["title"], name: "index_publicaciones_on_title"
    t.index ["unique_id"], name: "index_publicaciones_on_unique_id"
  end

  create_table "registros", force: :cascade do |t|
    t.string "doi"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doi"], name: "index_registros_on_doi"
    t.index ["institucion_id"], name: "index_registros_on_institucion_id"
  end

  create_table "relaciones", force: :cascade do |t|
    t.integer "parent_id"
    t.integer "child_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_relaciones_on_child_id"
    t.index ["parent_id"], name: "index_relaciones_on_parent_id"
  end

  create_table "revistas", force: :cascade do |t|
    t.string "revista"
    t.integer "idioma_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma_id"], name: "index_revistas_on_idioma_id"
    t.index ["revista"], name: "index_revistas_on_revista"
  end

  create_table "rutas", force: :cascade do |t|
    t.integer "instancia_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "perfil_id"
    t.index ["instancia_id"], name: "index_rutas_on_instancia_id"
    t.index ["perfil_id"], name: "index_rutas_on_perfil_id"
    t.index ["publicacion_id"], name: "index_rutas_on_publicacion_id"
  end

  create_table "sb_elementos", force: :cascade do |t|
    t.integer "orden"
    t.integer "nivel"
    t.string "tipo"
    t.string "elemento"
    t.string "acceso"
    t.boolean "activo"
    t.string "despliegue"
    t.string "controlador"
    t.integer "sb_lista_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_sb_elementos_on_orden"
    t.index ["sb_lista_id"], name: "index_sb_elementos_on_sb_lista_id"
  end

  create_table "sb_listas", force: :cascade do |t|
    t.string "lista"
    t.string "acceso"
    t.string "link"
    t.boolean "activa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suscripciones", force: :cascade do |t|
    t.integer "categoria_id"
    t.integer "perfil_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_suscripciones_on_categoria_id"
    t.index ["perfil_id"], name: "index_suscripciones_on_perfil_id"
  end

  create_table "tema_ayudas", force: :cascade do |t|
    t.integer "orden"
    t.string "tema_ayuda"
    t.text "detalle"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ilustracion"
    t.string "ilustracion_cache"
    t.boolean "activo"
    t.string "credito_foto"
    t.index ["activo"], name: "index_tema_ayudas_on_activo"
    t.index ["orden"], name: "index_tema_ayudas_on_orden"
    t.index ["tipo"], name: "index_tema_ayudas_on_tipo"
  end

  create_table "tutoriales", force: :cascade do |t|
    t.integer "orden"
    t.string "tutorial"
    t.text "detalle"
    t.integer "tema_ayuda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orden"], name: "index_tutoriales_on_orden"
    t.index ["tema_ayuda_id"], name: "index_tutoriales_on_tema_ayuda_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_usuarios_on_unlock_token", unique: true
  end

end
