class RelacionesController < ApplicationController
  before_action :set_relacion, only: [:show, :edit, :update, :destroy]

  # GET /relaciones
  # GET /relaciones.json
  def index
    @coleccion = Relacion.all
  end

  # GET /relaciones/1
  # GET /relaciones/1.json
  def show
  end

  # GET /relaciones/new
  def new
    @objeto = Relacion.new
  end

  # GET /relaciones/1/edit
  def edit
  end

  # POST /relaciones
  # POST /relaciones.json
  def create
    @objeto = Relacion.new(relacion_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Relacion was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relaciones/1
  # PATCH/PUT /relaciones/1.json
  def update
    respond_to do |format|
      if @objeto.update(relacion_params)
        format.html { redirect_to @objeto, notice: 'Relacion was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relaciones/1
  # DELETE /relaciones/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to relaciones_url, notice: 'Relacion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relacion
      @objeto = Relacion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def relacion_params
      params.require(:relacion).permit(:parent_id, :child_id)
    end
end
