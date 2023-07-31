class FiloConfElemsController < ApplicationController
  before_action :set_filo_conf_elem, only: [:show, :edit, :update, :destroy]

  # GET /filo_conf_elems
  # GET /filo_conf_elems.json
  def index
    @filo_conf_elems = FiloConfElem.all
  end

  # GET /filo_conf_elems/1
  # GET /filo_conf_elems/1.json
  def show
  end

  # GET /filo_conf_elems/new
  def new
    @filo_conf_elem = FiloConfElem.new
  end

  # GET /filo_conf_elems/1/edit
  def edit
  end

  # POST /filo_conf_elems
  # POST /filo_conf_elems.json
  def create
    @filo_conf_elem = FiloConfElem.new(filo_conf_elem_params)

    respond_to do |format|
      if @filo_conf_elem.save
        format.html { redirect_to @filo_conf_elem, notice: 'Filo conf elem was successfully created.' }
        format.json { render :show, status: :created, location: @filo_conf_elem }
      else
        format.html { render :new }
        format.json { render json: @filo_conf_elem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_conf_elems/1
  # PATCH/PUT /filo_conf_elems/1.json
  def update
    respond_to do |format|
      if @filo_conf_elem.update(filo_conf_elem_params)
        format.html { redirect_to @filo_conf_elem, notice: 'Filo conf elem was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_conf_elem }
      else
        format.html { render :edit }
        format.json { render json: @filo_conf_elem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_conf_elems/1
  # DELETE /filo_conf_elems/1.json
  def destroy
    @filo_conf_elem.destroy
    respond_to do |format|
      format.html { redirect_to filo_conf_elems_url, notice: 'Filo conf elem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_conf_elem
      @filo_conf_elem = FiloConfElem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_conf_elem_params
      params.require(:filo_conf_elem).permit(:filo_conflicto_id, :filo_elem_class, :filo_elem_id)
    end
end
