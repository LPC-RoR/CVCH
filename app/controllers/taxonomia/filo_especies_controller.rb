class Taxonomia::FiloEspeciesController < ApplicationController
  before_action :set_filo_especie, only: [:show, :edit, :update, :destroy, :buscar_etiquetas, :subir, :bajar, :nuevo_enlace, :elimina_conflicto, :mas_tipo_especie, :menos_tipo_especie, :mas_categoria_conservacion, :menos_categoria_conservacion, :asigna_regiones, :agrega_sinonimo ]

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

  # Taxonomía
  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    unless params[:nueva_especie][:filo_especie].blank?

      check = FiloEspecie.find_by(filo_especie: params[:nueva_especie][:filo_especie].downcase)
      if check.blank?
        filo_especie = params[:nueva_especie][:filo_especie].downcase
        referencia = params[:nueva_especie][:referencia].downcase
        nombre_comun = params[:nueva_especie][:nombre_comun].downcase
        link_fuente = params[:nueva_especie][:link_fuente]
        sinonimia = params[:nueva_especie][:sinonimia]
        revisar = params[:nueva_especie][:revisar]
        especie = FiloEspecie.create(filo_especie: filo_especie, referencia: referencia, nombre_comun: nombre_comun, link_fuente: link_fuente, sinonimia: sinonimia, revisar: revisar)

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
        padre.filo_especies << check if padre.class.name == 'FiloElemento'
        padre.children << check if padre.class.name == 'FiloEspecie'
        noticia = "Especie fue exitósamente reasignada #{check.id} #{padre.class.name} #{check.filo_elemento_id} #{check.filo_elemento.filo_elemento}"
      end

    else
      noticia = 'Debe contener el nombre de la especie'
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

  def agrega_sinonimo
    unless params[:nuevo_sinonimo][:filo_sinonimo].blank?
      fs=@objeto.filo_sinonimos.create(filo_sinonimo: params[:nuevo_sinonimo][:filo_sinonimo])
      fes=@objeto.filo_esp_sinos.find_by(filo_sinonimo_id: fs.id)
      fes.tipo = 'sinónimo'
      fes.save

      e=Especie.find_by(especie: fs.filo_sinonimo)
      fs.especie = e unless e.blank?
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: 'Sinónimo ha sido exitósamente creado'
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
    # 1ro PROCESAR LA ESPECIE
    # variables de la especie, ids_existentes y especie de la filo_especie
    ids_existentes = @objeto.especies.ids
    fe=Especie.find_by(especie: @objeto.filo_especie)
    fe_n_words = @objeto.filo_especie.strip.split(' ').length
    # Tratándose de una especie propia, No se relaciona a través de un filo_sinonimo
    unless fe.blank?
        @objeto.especies << fe unless ids_existentes.include?(fe.id)
    end

    # 2DO PROCESAR LA SINONIMIA SI EXISTE
    unless @objeto.sinonimia.blank?
      @objeto.sinonimos.each do |sinonimo|
        # Si el sinonimo no  existe lo crea, ya puede existir como sinonimo de otra especie
        fsin=FiloSinonimo.find_by(filo_sinonimo: sinonimo)
        fsin=FiloSinonimo.create(filo_sinonimo: sinonimo) if fsin.blank?
        fsin_n_words = sinonimo.strip.split(' ').length
        if fsin.manual == true
          fsin = false
          fsin.save
        end
        # lo agrega como sinonimo si ya no está agregado como sinonimo
        @objeto.filo_sinonimos << fsin unless @objeto.filo_sinonimos.ids.include?(fsin.id)
        # si el sinónimo es su especie padre, marca el sinonimo como excluido : si no lo marca com sinónimo
        fes=fsin.filo_esp_sinos.find_by(filo_especie_id: @objeto.id)
        if fe_n_words > fsin_n_words
          fe_genero = @objeto.filo_especie.strip.split(' ')[0]
          fsin_genero = sinonimo.strip.split(' ')[0]
          fe_nombre = @objeto.filo_especie.strip.split(' ')[1]
          fsin_nombre = sinonimo.strip.split(' ')[1]
          if fe_genero == fsin_genero and fe_nombre == fsin_nombre
            unless fes.blank?
              fes.tipo = 'excluido'
              fes.save
            end
          end
        else
          unless fes.blank?
            fes.tipo = 'sinónimo'
            fes.save
          end
        end

        sin=Especie.find_by(especie: sinonimo)
        unless sin.blank?
          fsin.especie = sin unless fsin.especie.present?
          @objeto.especies.delete(sin) if ids_existentes.include?(sin.id) and sin.id != fe.id
        end

        # Manego de especie/sub_especie
      end
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: "Sinónimos: #{@objeto.sinonimos.join('; ') unless @objeto.sinonimia.blank?}"
  end

  def subir
    if @objeto.valid?
      # @objeto.parent SIEMPRE EXISTE
      padre = @objeto.parent.present? ? @objeto.parent : @objeto.filo_elemento
      abuelo = @objeto.parent.present? ? padre.filo_elemento : padre.parent
      if padre.class.name == 'FiloElemento'
        padre.filo_especies.delete(@objeto)
      else
        padre.children.delete(@objeto)
      end

      abuelo.filo_especies << @objeto unless abuelo.blank?
      noticia = 'especie se movió exitósamente'
    else
      noticia = 'registro incompleto: nose puede mover'
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: noticia
  end

  def bajar
    if @objeto.valid?
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
      noticia = 'especie se movió exitósamente'
    else
      noticia = 'registro incompleto: nose puede mover'
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: noticia
  end

  def mas_tipo_especie
    tipo_especie = FiloTipoEspecie.find(params[:indice])
    @objeto.filo_tipo_especies << tipo_especie unless tipo_especie.blank?

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def menos_tipo_especie
    tipo_especie = FiloTipoEspecie.find(params[:indice])
    @objeto.filo_tipo_especies.delete(tipo_especie) unless tipo_especie.blank?

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def mas_categoria_conservacion
    categoria = FiloCategoriaConservacion.find(params[:indice])
    @objeto.filo_categoria_conservaciones << categoria unless categoria.blank?

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def menos_categoria_conservacion
    categoria = FiloCategoriaConservacion.find(params[:indice])
    @objeto.filo_categoria_conservaciones.delete(categoria) unless categoria.blank?

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def asigna_regiones
    ids_asignadas = @objeto.regiones.ids
    Region.all.order(:orden).each do |region|
      unless ( params[:key] == 'norte' and region.orden > 6 ) or ( params[:key] == 'sur' and region.orden < 8 )
        @objeto.regiones << region unless ids_asignadas.include?(region.id)
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
      params.require(:filo_especie).permit(:filo_especie, :referencia, :nombre_comun, :iucn, :filo_elemento_id, :mma_ok, :revisar, :filo_tipo_especie_id, :filo_categoria_conservacion_id, :sinonimia, :rara, :link_fuente)
    end
end
