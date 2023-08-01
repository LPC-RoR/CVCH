class Taxonomia::FiloEspeciesController < ApplicationController
  before_action :set_filo_especie, only: [:show, :edit, :update, :destroy, :buscar_etiquetas, :subir, :bajar, :nuevo_enlace, :elimina_conflicto ]

  helper_method :sort_column, :sort_direction

  # GET /filo_especies
  # GET /filo_especies.json
  def index
    @coleccion = FiloEspecie.all
  end

  # GET /filo_especies/1
  # GET /filo_especies/1.json
  def show
    init_tabla('publicaciones', Publicacion.where(id: @objeto.publicaciones_ids).order(sort_column + " " + sort_direction), true)
    add_tabla('filo_especies', @objeto.children, false )
    add_tabla('sinonimos-filo_especies', @objeto.sinonimos, false)

    add_tabla('especies', @objeto.especies, false)

    @coleccion_usuario = perfil_activo.carpetas.order(:carpeta)
    @coleccion_publicacion = @objeto.carpetas
  end

  # GET /filo_especies/new
  def new
    @objeto = FiloEspecie.new(filo_elemento_id: params[:filo_elemento_id])
  end

  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie][:filo_especie].blank? or params[:nueva_especie][:filo_tipo_especie_id].blank? or params[:nueva_especie][:filo_categoria_conservacion_id].blank?
      especie = FiloEspecie.create(filo_especie: params[:nueva_especie][:filo_especie].downcase, nombre_comun: params[:nueva_especie][:nombre_comun].downcase, filo_tipo_especie_id: params[:nueva_especie][:filo_tipo_especie_id], filo_categoria_conservacion_id: params[:nueva_especie][:filo_categoria_conservacion_id])
      unless padre.blank? or especie.blank?
        etiquetas = Etiqueta.where(especie: especie.filo_especie)
        unless etiquetas.empty?
          etiquetas.each do |etiqueta|
            especie.especies << etiqueta
          end
        end
        padre.filo_especies << especie if params[:class_name] == 'FiloElemento'
        padre.children << especie if params[:class_name] == 'FiloEspecie'
      end
      noticia = 'Especie fue exitósamente creada'
    else
      noticia = 'Información incompleta'
    end

    redirect_to "/publicos/#{params[:class_name]=='FiloElemento' ? 'taxonomia' : 'especies'}?indice=#{padre.id}", notice: noticia
  end

  def nuevo_child
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie_child][:filo_especie].blank?
      textos = params[:nueva_especie_child][:filo_especie].split('|')
      tex_espe = textos[0]
      tex_ncom = textos.count == 2 ? textos[1] : nil
      especie = FiloEspecie.create(filo_especie: tex_espe.capitalize, nombre_comun: tex_ncom)
      padre.children << especie unless padre.blank?
    end

    redirect_to "/especies?especie=#{padre.filo_especie unless padre.blank?}"
  end

  def nuevo_enlace
    AppEnlace.create(owner_class: @objeto.class.name, owner_id: @objeto.id, descripcion: params[:nuevo_enlace][:descripcion], enlace: params[:nuevo_enlace][:enlace])

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  # GET /filo_especies/1/edit
  def edit
  end

  # POST /filo_especies
  # POST /filo_especies.json
  def create
    @objeto = FiloEspecie.new(filo_especie_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Especie fue exitósamente creada.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_especies/1
  # PATCH/PUT /filo_especies/1.json
  def update
    respond_to do |format|
      if @objeto.update(filo_especie_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Especie fue exitósamente actualizada.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  def asigna
    carpeta = Carpeta.find(params[:objeto_id])
    unless carpeta.blank? or params[:busca_especie][:especie].blank?
      especie = FiloEspecie.find_by(filo_especie: params[:busca_especie][:especie].downcase)
      carpeta.filo_especies << especie unless especie.blank?
    end

    redirect_to carpeta
  end

  def nueva_subespecie
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:nueva_subespecie][:filo_especie].blank?
      check_filo_especie = FiloEspecie.find_by(filo_especie: params[:nueva_subespecie][:filo_especie].downcase)
      if check_filo_especie.blank?
        nueva = FiloEspecie.create(filo_especie: params[:nueva_subespecie][:filo_especie].downcase, nombre_comun: params[:nueva_subespecie][:nombre_comun].downcase, iucn: params[:nueva_subespecie][:iucn])
        filo_especie.children << nueva

        etiquetas = Especie.where(especie: nueva.filo_especie)
        etiquetas.each do |etiqueta|
          nueva.especies << etiqueta
        end
      end
    end
    
    redirect_to filo_especie
  end

  def nuevo_sinonimo
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:nuevo_sinonimo][:sinonimo].blank?
      check_sinonimo = FiloEspecie.find_by(filo_especie: params[:nuevo_sinonimo][:sinonimo].downcase)
      if check_sinonimo.blank?
        sinonimo = FiloEspecie.create(filo_especie: params[:nuevo_sinonimo][:sinonimo].downcase)
        filo_especie.sinonimos << sinonimo

        etiquetas = Especie.where(especie: sinonimo.filo_especie)
        etiquetas.each do |etiqueta|
          sinonimo.especies << etiqueta
        end
      end
    end
    
    redirect_to filo_especie
  end

  def asocia_etiqueta
    filo_especie = FiloEspecie.find(params[:objeto_id])
    unless params[:asocia_etiqueta][:etiqueta].blank?
      etiqueta = params[:asocia_etiqueta][:etiqueta].match(/^\d+$/) ? Especie.find(params[:asocia_etiqueta][:etiqueta].to_i) : Especie.find_by(especie: params[:asocia_etiqueta][:etiqueta].downcase)
      filo_especie.especies << etiqueta unless etiqueta.blank?
    end

    redirect_to filo_especie
  end

  # DELETE /filo_especies/1
  # DELETE /filo_especies/1.json
  def destroy
    @objeto.destroy
    set_redireccion
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Especie fue exitósamente eliminada.' }
      format.json { head :no_content }
    end
  end

  def elimina
    @objeto = FiloEspecie.find(params[:objeto_id])

    if @objeto.padre.class.name == 'FiloEspecie'
      padre = @objeto.parent 
      padre.children.delete(@objeto)
    end

    @objeto.delete

    if @objeto.padre.class.name == 'FiloEspecie'
      redirect_to "/especies?especie=#{@objeto.padre.filo_especie}"
    else
      redirect_to "/especies?elemento=#{@objeto.padre.filo_elemento}"
    end
  end

  # NUEVOS

  def elimina_conflicto
    conflicto = FiloConflicto.find(params[:indice]) 
    filo_elems = conflicto.filo_conf_elems
    filo_elems.delete_all
    conflicto.delete

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def buscar_etiquetas
    #para chequear las etiquetas ya asignadas
    ids_existentes = @objeto.especies.ids

    # buscar filo_especie
    fe=Especie.find_by(especie: @objeto.filo_especie)

    unless fe.blank?
      unless ids_existentes.include?(fe.id)
        if fe.filo_especie.present? and fe.filo_especie.filo_especie != fe.especie
          #crea conflicto y reasigna, tiene preferencia la etiqueta propia
          conflicto = perfil_activo.filo_conflictos.create( huella: "#{@objeto.filo_especie} ? #{fe.especie} : #{fe.filo_especie.filo_especie}",filo_conflicto:  "Reasigna etiqueta propia")
          conflicto.filo_conf_elems.create(filo_elem_class: 'FiloEspecie', filo_elem_id: @objeto.id)
          conflicto.filo_conf_elems.create(filo_elem_class: 'FiloEspecie', filo_elem_id: fe.filo_especie.id)
          conflicto.filo_conf_elems.create(filo_elem_class: 'Especie', filo_elem_id: fe.id)
        end
        @objeto.especies << fe
      end
    end

    unless @objeto.sinonimia.blank?
      # buscar sinonimia
      @objeto.sinonimos.each do |sinonimo|
        sin=Especie.find_by(especie: sinonimo)
        unless sin.blank? or sin.id == fe.id or ids_existentes.include?(sin.id)

          if sin.filo_especie.present? and sin.filo_especie.filo_especie != sin.especie
            unless sin.filo_especie.en_desuso
              #crea conflicto sin reasignar
              conflicto = perfil_activo.filo_conflictos.create( huella: "#{@objeto.filo_especie} ? #{sin.especie} : #{sin.filo_especie.filo_especie}",filo_conflicto:  "Sinónimo en conflicto")
              conflicto.filo_conf_elems.create(filo_elem_class: 'FiloEspecie', filo_elem_id: @objeto.id)
              conflicto.filo_conf_elems.create(filo_elem_class: 'FiloEspecie', filo_elem_id: sin.filo_especie.id)
              conflicto.filo_conf_elems.create(filo_elem_class: 'Especie', filo_elem_id: sin.id)
            else
              @objeto.especies << sin
            end
          else
            @objeto.especies << sin
          end

        end
      end
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: "Sinónimos: #{@objeto.sinonimos.join('; ') unless @objeto.sinonimia.blank?}"
  end

  def mover
    destino = params[:cls].constantize.find(params[:tio])
    if params[:cls] == 'FiloElemento'
      # Especie
      padre = @objeto.filo_elemento
      destino.filo_especies << @objeto
      padre.filo_especies.delete(@objeto)
    else
      # Sub Especie
      padre = @objeto.parent
      destino.children << @objeto
      padre.children.delete(@objeto)
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def subir
    # @objeto.parent SIEMPRE EXISTE
    padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
    abuelo = @objeto.parent.present? ? padre.filo_elemento : padre.parent
    if padre.class.name == 'FiloElemento'
      padre.filo_especies.delete(@objeto)
    else
      padre.children.delete(@objeto)
    end

    abuelo.filo_especies << @objeto unless abuelo.blank?

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def bajar
    padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
    nuevo_padre = params[:class].constantize.find(params[:indice])

    if padre.class.name == 'FiloElemento'
      padre.filo_especies.delete(@objeto)
      if nuevo_padre.class.name == 'FiloElemento'
        nuevo_padre.filo_especies << @objeto
      else
        nuevo_padre.children << @objeto
      end
    end
    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  private

    def sort_column
      Publicacion.column_names.include?(params[:sort]) ? params[:sort] : "Author"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_filo_especie
      @objeto = FiloEspecie.find(params[:id])
    end

    def set_redireccion
      if @objeto.destroyed?
        @redireccion = @objeto.parent.present? ? "/publicos/especies?indice=#{@objeto.parent.id}" : "/publicos/taxonomia?indice=#{@objeto.filo_elemento.id}"
      else
        @redireccion = "/publicos/especies?indice=#{@objeto.id}"
      end
    end

    # Only allow a list of trusted parameters through.
    def filo_especie_params
      params.require(:filo_especie).permit(:filo_especie, :referencia, :nombre_comun, :iucn, :filo_elemento_id, :mma_ok, :revisar, :filo_tipo_especie_id, :filo_categoria_conservacion_id, :sinonimia, :rara)
    end
end
