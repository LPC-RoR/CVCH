class FiloConflictosController < ApplicationController
  before_action :set_filo_conflicto, only: [:show, :edit, :update, :destroy]

  # GET /filo_conflictos
  # GET /filo_conflictos.json
  def index
    @filo_conflictos = FiloConflicto.all
  end

  # GET /filo_conflictos/1
  # GET /filo_conflictos/1.json
  def show
  end

  # GET /filo_conflictos/new
  def new
    @filo_conflicto = FiloConflicto.new
  end

  # GET /filo_conflictos/1/edit
  def edit
  end

  # POST /filo_conflictos
  # POST /filo_conflictos.json
  def create
    @filo_conflicto = FiloConflicto.new(filo_conflicto_params)

    respond_to do |format|
      if @filo_conflicto.save
        format.html { redirect_to @filo_conflicto, notice: 'Filo conflicto was successfully created.' }
        format.json { render :show, status: :created, location: @filo_conflicto }
      else
        format.html { render :new }
        format.json { render json: @filo_conflicto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_conflictos/1
  # PATCH/PUT /filo_conflictos/1.json
  def update
    respond_to do |format|
      if @filo_conflicto.update(filo_conflicto_params)
        format.html { redirect_to @filo_conflicto, notice: 'Filo conflicto was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_conflicto }
      else
        format.html { render :edit }
        format.json { render json: @filo_conflicto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_conflictos/1
  # DELETE /filo_conflictos/1.json
  def destroy
    @filo_conflicto.destroy
    respond_to do |format|
      format.html { redirect_to filo_conflictos_url, notice: 'Filo conflicto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_conflicto
      @filo_conflicto = FiloConflicto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_conflicto_params
      params.require(:filo_conflicto).permit(:app_perfil_id, :filo_conflicto, :detalle, :resuelto)
    end
end
