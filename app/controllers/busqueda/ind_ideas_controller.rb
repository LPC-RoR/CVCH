class Busqueda::IndIdeasController < ApplicationController
  before_action :set_ind_idea, only: [:show, :edit, :update, :destroy]

  # GET /ind_ideas
  # GET /ind_ideas.json
  def index
    @coleccion = IndIdea.all
  end

  # GET /ind_ideas/1
  # GET /ind_ideas/1.json
  def show
  end

  # GET /ind_ideas/new
  def new
    @objeto = IndIdea.new
  end

  # GET /ind_ideas/1/edit
  def edit
  end

  # POST /ind_ideas
  # POST /ind_ideas.json
  def create
    @objeto = IndIdea.new(ind_idea_params)

    respond_to do |format|
      if @objeto.save
        format.html { redirect_to @objeto, notice: 'Ind idea was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ind_ideas/1
  # PATCH/PUT /ind_ideas/1.json
  def update
    respond_to do |format|
      if @objeto.update(ind_idea_params)
        format.html { redirect_to @objeto, notice: 'Ind idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ind_ideas/1
  # DELETE /ind_ideas/1.json
  def destroy
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to ind_ideas_url, notice: 'Ind idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ind_idea
      @objeto = IndIdea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ind_idea_params
      params.require(:ind_idea).permit(:ind_estructura_id, :ind_idea)
    end
end
