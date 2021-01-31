class AreasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :inicia_session
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  # GET /areas
  # GET /areas.json
  def index
    @coleccion = Area.all
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    if params[:html_options].blank?
      @tab = 'papers'
    else
      @tab = params[:html_options][:tab].blank? ? 'papers' : params[:html_options][:tab]
    end
    @coleccion = @objeto.papers.where(estado: 'publicada').page(params[:page])
    @options = {'tab' => @tab}
  end

  # GET /areas/new
  def new
    @objeto = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @objeto = Area.new(area_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @objeto.update(area_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @objeto = Area.find(params[:id])
    end

    def set_redireccion
      @redireccion = '/areas'
    end

    # Only allow a list of trusted parameters through.
    def area_params
      params.require(:area).permit(:area)
    end
end
