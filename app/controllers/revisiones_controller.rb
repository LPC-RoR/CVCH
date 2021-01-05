class RevisionesController < ApplicationController
  before_action :set_revision, only: [:show, :edit, :update, :destroy]

  # GET /revisiones
  # GET /revisiones.json
  def index
    # BI FRAME
    # ftab y sel
    if params[:html_options].blank?
      @ftab = 'Cargas'
      @area = Area.first
    else
      @ftab = params[:html_options]['ftab'].blank? ? 'Cargas' : params[:html_options]['ftab']
      @area = params[:html_options]['sel'].blank? ? Area.first : Area.find_by(area: params[:html_options]['sel'])
    end

    # Lista de 'selectors'
    @frame_selector = Area.all.map {|a| [a.area, a.papers.where(estado: @ftab.singularize.downcase).count]}
    # CONTROLADOR de la tabla a depslegar
    @table_controller = 'publicaciones'

    # selector activo
    @sel = @area.area
    # opciones para los links
    @options = {'sel' => @sel ,'ftab' => @ftab}

    @coleccion = (@ftab == 'Contribuciones' ? Publicacion.where(estado: 'contribucion').page(params[:page]) : @area.papers.where(estado: @ftab.singularize.downcase).page(params[:page]))

#    @coleccion = @area.papers.where(estado: @ftab.singularize.downcase).page(params[:page])

  end

  # GET /revisiones/1
  # GET /revisiones/1.json
  def show
  end

  # GET /revisiones/new
  def new
    @objeto = Revision.new
  end

  # GET /revisiones/1/edit
  def edit
  end

  # POST /revisiones
  # POST /revisiones.json
  def create
    @objeto = Revision.new(revision_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Revision was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /revisiones/1
  # PATCH/PUT /revisiones/1.json
  def update
    respond_to do |format|
      if @objeto.update(revision_params)
        format.html { redirect_to @objeto, notice: 'Revision was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /revisiones/1
  # DELETE /revisiones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to revisiones_url, notice: 'Revision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revision
      @objeto = Revision.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def revision_params
      params.fetch(:revision, {})
    end
end
