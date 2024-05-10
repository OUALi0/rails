class AuteursController < ApplicationController
  before_action :set_auteur, only: %i[ show edit update destroy ]
  $auteurs = []
  $query = ''
  # GET /auteurs or /auteurs.json
  def index
    if(params[:query].nil?)
      $auteurs = Auteur.all
      @documents = Document.all
      return
    end

    query = params[:query]
    $auteurs = search(query)
  end
  def search(query)
    @documents = Document.all
    res = Auteur.all.where("lower(nom_prenom) LIKE :search", search:"%#{query}%")
    return res
  end
  # GET /auteurs/1 or /auteurs/1.json
  def show
    @documents = Document.all
  end

  # GET /auteurs/new
  def new
    @auteur = Auteur.new
    @documents = Document.all
  end

  # GET /auteurs/1/edit
  def edit
    @documents = Document.all
  end

  # POST /auteurs or /auteurs.json
  def create
    @auteur = Auteur.new(auteur_params)
    @documents = Document.all
    respond_to do |format|
      if @auteur.save
        format.html { redirect_to auteur_url(@auteur), notice: "Auteur was successfully created." }
        format.json { render :show, status: :created, location: @auteur }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auteur.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /auteurs/1 or /auteurs/1.json
  def update
    @documents = Document.all
    respond_to do |format|
      if @auteur.update(auteur_params)
        format.html { redirect_to auteur_url(@auteur), notice: "Auteur was successfully updated." }
        format.json { render :show, status: :ok, location: @auteur }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auteur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auteurs/1 or /auteurs/1.json
  def destroy
    @auteur.destroy

    respond_to do |format|
      format.html { redirect_to auteurs_url, notice: "Auteur was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auteur
      @documents = Document.all
      @auteur = Auteur.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def auteur_params
      params.require(:auteur).permit(:nom_prenom)
    end
end
