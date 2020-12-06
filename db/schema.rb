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

ActiveRecord::Schema.define(version: 2020_12_05_214345) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer "investigador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "area_id"
    t.string "status"
    t.index ["area_id"], name: "index_cargas_on_area_id"
    t.index ["investigador_id"], name: "index_cargas_on_investigador_id"
  end

  create_table "carpetas", force: :cascade do |t|
    t.string "carpeta"
    t.integer "investigador_id"
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carpeta"], name: "index_carpetas_on_carpeta"
    t.index ["equipo_id"], name: "index_carpetas_on_equipo_id"
    t.index ["investigador_id"], name: "index_carpetas_on_investigador_id"
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
    t.index ["concepto"], name: "index_conceptos_on_concepto"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "departamento"
    t.integer "institucion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institucion_id"], name: "index_departamentos_on_institucion_id"
  end

  create_table "equipos", force: :cascade do |t|
    t.string "equipo"
    t.string "sha1"
    t.integer "administrador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["administrador_id"], name: "index_equipos_on_administrador_id"
    t.index ["equipo"], name: "index_equipos_on_equipo"
    t.index ["sha1"], name: "index_equipos_on_sha1"
  end

  create_table "evaluaciones", force: :cascade do |t|
    t.string "aspecto"
    t.string "evaluacion"
    t.integer "publicacion_id"
    t.integer "investigador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aspecto"], name: "index_evaluaciones_on_aspecto"
    t.index ["investigador_id"], name: "index_evaluaciones_on_investigador_id"
    t.index ["publicacion_id"], name: "index_evaluaciones_on_publicacion_id"
  end

  create_table "idiomas", force: :cascade do |t|
    t.string "idioma"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["idioma"], name: "index_idiomas_on_idioma"
  end

  create_table "instancias", force: :cascade do |t|
    t.string "instancia"
    t.string "sha1"
    t.integer "concepto_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["concepto_id"], name: "index_instancias_on_concepto_id"
    t.index ["sha1"], name: "index_instancias_on_sha1"
  end

  create_table "instituciones", force: :cascade do |t|
    t.string "institucion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "integrantes", force: :cascade do |t|
    t.integer "investigador_id"
    t.integer "equipo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipo_id"], name: "index_integrantes_on_equipo_id"
    t.index ["investigador_id"], name: "index_integrantes_on_investigador_id"
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

  create_table "procesos", force: :cascade do |t|
    t.integer "carga_id"
    t.integer "publicacion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carga_id"], name: "index_procesos_on_carga_id"
    t.index ["publicacion_id"], name: "index_procesos_on_publicacion_id"
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
    t.integer "equipo_id"
    t.integer "investigador_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "d_quote"
    t.string "doc_type"
    t.string "estado"
    t.string "academic_degree"
    t.string "book"
    t.string "t_sha1"
    t.index ["doc_type"], name: "index_publicaciones_on_doc_type"
    t.index ["equipo_id"], name: "index_publicaciones_on_equipo_id"
    t.index ["estado"], name: "index_publicaciones_on_estado"
    t.index ["investigador_id"], name: "index_publicaciones_on_investigador_id"
    t.index ["origen"], name: "index_publicaciones_on_origen"
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
    t.index ["instancia_id"], name: "index_rutas_on_instancia_id"
    t.index ["publicacion_id"], name: "index_rutas_on_publicacion_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

end
