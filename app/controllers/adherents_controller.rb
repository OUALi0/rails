class AdherentsController < ApplicationController
  before_action :set_adherent, only: %i[ show edit update destroy ]
  $search_triggered = false
  $adherents = []
  $query = ''
  # def initialize()
  #   @search_triggered = false
  # end

  # GET /adherents or /adherents.json
  def index

    if(params[:query].nil?)
      $adherents = Adherent.all
      return
    end

    query = params[:query]
    $adherents = search(query)
  end

  # GET /adherents/1 or /adherents/1.json
  def show
  end

  # GET /adherents/new
  def new
    @adherent = Adherent.new
  end

  # GET /adherents/1/edit
  def edit
  end

  # POST /adherents or /adherents.json
  def create
    @adherent = Adherent.new(adherent_params)

    respond_to do |format|
      if @adherent.save
        format.html { redirect_to adherents_url, notice: "Adherent was successfully created." }
        format.json { render :show, status: :created, location: @adherent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @adherent.errors, status: :unprocessable_entity }
      end

    end
  end


  def search(query)
    res = Adherent.all.where("lower(nom) LIKE :search", search:"%#{query}%")
    return res
  end

  # PATCH/PUT /adherents/1 or /adherents/1.json
  def update
    respond_to do |format|
      if @adherent.update(adherent_params)
        format.html { redirect_to adherent_url(@adherent), notice: "Adherent was successfully updated." }
        format.json { render :show, status: :ok, location: @adherent }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @adherent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /adherents/1 or /adherents/1.json
  def destroy
    @adherent.destroy

    respond_to do |format|
      format.html { redirect_to adherents_url, notice: "Adherent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_adherent
      @adherent = Adherent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def adherent_params
      params.require(:adherent).permit(:nom, :prenom, :id)
    end
end
