class Taxonomia::FiloEspeciesController < ApplicationController
  before_action :set_filo_especie, only: [:show, :edit, :update, :destroy, :buscar_etiquetas, :subir, :bajar, :nuevo_enlace, :elimina_conflicto, :mas_tipo_especie, :menos_tipo_especie, :mas_categoria_conservacion, :menos_categoria_conservacion, :asigna_regiones, :agrega_sinonimo, :borra_especie_sinonimo ]

  helper_method :sort_column, :sort_direction

  # GET /filo_especies
  # GET /filo_especies.json
  def index
    @coleccion = FiloEspecie.all
  end

  # GET /filo_especies/1
  # GET /filo_especies/1.json
  def show
  end

  # GET /filo_especies/new
  def new
    @objeto = FiloEspecie.new(filo_elemento_id: params[:filo_elemento_id])
  end

  # VERIFICADO y REVISADA
  # Agrega filo_especie a FiloElemento o FiloEspecie
  # Taxonomía
  def nuevo
    padre = params[:class_name].blank? ? nil : params[:class_name].constantize.find(params[:objeto_id])
    params_ne = params[:nueva_especie]

    unless params_ne[:filo_especie].blank? or padre.blank?
      filo_especie = params_ne[:filo_especie].gsub(/\t|\r|\n/, ' ').strip.downcase.split(' ').join(' ')
      check = FiloEspecie.find_by(filo_especie: filo_especie)

      if check.blank?
        # Especie no existe !!
        referencia = params_ne[:referencia].downcase
        nombre_comun = params_ne[:nombre_comun].downcase
        link_fuente = params_ne[:link_fuente]
        sinonimia = params_ne[:nueva_especie][:sinonimia]
        revisar = params_ne[:nueva_especie][:revisar]

        nueva_especie = FiloEspecie.create(filo_especie: filo_especie, referencia: referencia, nombre_comun: nombre_comun, link_fuente: link_fuente, sinonimia: sinonimia, revisar: revisar)

        unless nueva_especie.blank?
          noticia = 'especie/subespecie fue exitósamente creada'
          # agrega al elemento/especie según corresponda
          padre.filo_especies << nueva_especie if params[:class_name] == 'FiloElemento'
          padre.children << nueva_especie if params[:class_name] == 'FiloEspecie'
          # se asignan etiquetas cuando corresponde
          etiquetas = Etiqueta.where(especie: nueva_especie.filo_especie)
          unless etiquetas.empty?
            etiquetas.each do |etiqueta|
              nueva_especie.especies << etiqueta
            end
          end
        else
          noticia = 'Error: no se pudo crear especie/subespecie!'
        end
      else
        noticia = "Especie ya existe con el id: #{check.id}"
      end
    else
      noticia = padre.blank? ? 'Error: especie/subespecie debe tener un padre' : 'Error: No se puede crear una especie/subespecie sin nombre'
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

  # POST
  # Verificado
  # agrega sinónimos a filo_especie desde form_nuevo_sinonimo
  def agrega_sinonimo
    sinonimo = params[:nuevo_sinonimo][:filo_sinonimo]
    agrega_filo_sinonimo(@objeto, sinonimo, true)

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
    # busca ESPECIE de FILO_ESPECIE (@objeto)
    ids_existentes = @objeto.especies.ids
    fe=Especie.find_by(especie: @objeto.filo_especie)

    # Tratándose de una especie propia, No se relaciona a través de un filo_sinonimo
    unless fe.blank?
        @objeto.especies << fe unless ids_existentes.include?(fe.id)
    end

    # 2DO PROCESAR LA SINONIMIA SI EXISTE
    # multiple_sinonimia? verifica si filo_especie tiene sinonimia o tiene actualizaciones que la tengan
    if @objeto.multiple_sinonimia?
      # sinonimos entrega un arreglo con las sinonimias multiples o no
      @objeto.sinonimos.each do |sinonimo|
        agrega_filo_sinonimo(@objeto, sinonimo, false)
      end
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: "Sinónimos: #{@objeto.sinonimos.join('; ') unless @objeto.sinonimia.blank?}"
  end

  def subir
    if dog?
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
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: noticia
  end

  def bajar
    if dog?
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
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}", notice: noticia
  end

  def mas_tipo_especie
    if admin?
      tipo_especie = FiloTipoEspecie.find(params[:indice])
      @objeto.filo_tipo_especies << tipo_especie unless tipo_especie.blank?
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def menos_tipo_especie
    if admin?
      tipo_especie = FiloTipoEspecie.find(params[:indice])
      @objeto.filo_tipo_especies.delete(tipo_especie) unless tipo_especie.blank?
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def mas_categoria_conservacion
    if admin?
      categoria = FiloCategoriaConservacion.find(params[:indice])
      @objeto.filo_categoria_conservaciones << categoria unless categoria.blank?
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def menos_categoria_conservacion
    if admin?
      categoria = FiloCategoriaConservacion.find(params[:indice])
      @objeto.filo_categoria_conservaciones.delete(categoria) unless categoria.blank?
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  def asigna_regiones
    if admin?
      ids_asignadas = @objeto.regiones.ids
      Region.all.order(:orden).each do |region|
        unless ( params[:key] == 'norte' and region.orden > 6 ) or ( params[:key] == 'sur' and region.orden < 8 )
          @objeto.regiones << region unless ids_asignadas.include?(region.id)
        end
      end
    end

    redirect_to "/publicos/especies?indice=#{@objeto.id}"
  end

  private

    # VERIFICADO
    def agrega_filo_sinonimo(filo_especie, sinonimo, manual)
      existentes = filo_especie.filo_sinonimos.map {|fs| fs.filo_sinonimo}
      # no crea sinonimos de si mismo o ya existentes
      unless filo_especie.filo_especie == sinonimo or existentes.include?(sinonimo)

        # Si el sinonimo no  existe lo crea, ya puede existir como sinonimo de otra especie
        fsin=FiloSinonimo.find_by(filo_sinonimo: sinonimo)
        fsin=FiloSinonimo.create(filo_sinonimo: sinonimo) if fsin.blank?
        # cuál es la diferencia entre manual {true / false}?
        fsin.manual = manual
        fsin.save

        # Si el sinónimo existe como filo_especie
        fe_sin = FiloEspecie.find_by(filo_especie: sinonimo)
        unless fe_sin.blank?
          # si no es MMA y además no tiene hijos ni sinónimos, se libera especie y se borra fe_sin
          if fe_sin.link_fuente.blank? and fe_sin.children.empty? and fe_sin.filo_sinonimos.empty?
            especie = fe_sin.especie
            unless especie.blank?
              especie.filo_especie_id = nil
              especie.save
            end
            fe_sin.delete
          # filo_especie con subespecies o filo_sinónimos o en estructura MMA
          else
            # el padre de filo_especie de la especie es igual al padre
            # marcamos filo_especie como filo_especie heredado
            # filo especie que podría ser borrada
            if fe_sin.parent == filo_especie
              fe_sin.feh = true
              fe_sin.save
            # el padre del padre es igual a filo_especie
            # marcamos al padre como filo_especie heredado, posible de ser borrado
            elsif filo_especie.parent == fe_sin
              filo_especie.feh = true
              filo_especie.save
            end
          end
        end

        # no verifica porque las colisiones son parte de la información
        filo_especie.filo_sinonimos << fsin
        # marcamos el nuevo sinónimo como {agregado o sinónimo}
        fes=fsin.filo_esp_sinos.find_by(filo_especie_id: filo_especie.id)
        unless fes.blank?
          fes.tipo = (manual ? 'agregado' : 'sinónimo')
          fes.save
        end

        # Buscamos la especie del sinónimo
        sin=Especie.find_by(especie: sinonimo)
        unless sin.blank?
          fsin.especie = sin unless fsin.especie.present?
        end

      end
    end

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
