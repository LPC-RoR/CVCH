class FiloEleElesController < ApplicationController
  before_action :set_filo_ele_el, only: [:show, :edit, :update, :destroy]

  # GET /filo_ele_eles
  # GET /filo_ele_eles.json
  def index
    @filo_ele_eles = FiloEleEle.all
  end

  # GET /filo_ele_eles/1
  # GET /filo_ele_eles/1.json
  def show
  end

  # GET /filo_ele_eles/new
  def new
    @filo_ele_el = FiloEleEle.new
  end

  # GET /filo_ele_eles/1/edit
  def edit
  end

  # POST /filo_ele_eles
  # POST /filo_ele_eles.json
  def create
    @filo_ele_el = FiloEleEle.new(filo_ele_el_params)

    respond_to do |format|
      if @filo_ele_el.save
        format.html { redirect_to @filo_ele_el, notice: 'Filo ele ele was successfully created.' }
        format.json { render :show, status: :created, location: @filo_ele_el }
      else
        format.html { render :new }
        format.json { render json: @filo_ele_el.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filo_ele_eles/1
  # PATCH/PUT /filo_ele_eles/1.json
  def update
    respond_to do |format|
      if @filo_ele_el.update(filo_ele_el_params)
        format.html { redirect_to @filo_ele_el, notice: 'Filo ele ele was successfully updated.' }
        format.json { render :show, status: :ok, location: @filo_ele_el }
      else
        format.html { render :edit }
        format.json { render json: @filo_ele_el.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filo_ele_eles/1
  # DELETE /filo_ele_eles/1.json
  def destroy
    @filo_ele_el.destroy
    respond_to do |format|
      format.html { redirect_to filo_ele_eles_url, notice: 'Filo ele ele was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filo_ele_el
      @filo_ele_el = FiloEleEle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def filo_ele_el_params
      params.require(:filo_ele_el).permit(:parent_id, :child_id)
    end
end
