class AuteursController < ApplicationController
  before_action :set_auteur, only: %i[ show edit update destroy ]
  $auteurs = []
  $query = ''
  def index
    if params[:query].present?
      $auteurs = search(params[:query])
    else
      $auteurs = Auteur.includes(:documents).all
    end
    @documents = Document.all
  end
  def search(query)
    @documents = Document.all
    res = Auteur.all.where("lower(nom_prenom) LIKE :search", search:"%#{query}%")
    return res
  end
  def show
    @documents = Document.all
  end
  def new
    @auteur = Auteur.new
    @documents = Document.all
  end
  def edit
    @documents = Document.all
  end

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

  def charger_table
    require 'csv'
    csv_file_path = 'C:\Users\OUALID\Downloads\auteurs.csv'
    # Lecture du fichier CSV
    CSV.foreach(csv_file_path, headers: true) do |row|
        puts row.inspect
        # Extracting author names
        documents_names = row['Document'].split(',').map(&:strip)
        # Find or create authors
        documents = []
        documents_names.each do |document_name|
          document = Document.find_or_create_by(titre: document_name)
          documents << document
        end
    # Création d'une nouvelle instance de auteur avec les attributs du CSV
    auteur = Auteur.new(
        id: row['ID'],
        nom_prenom: row['Full Name']
    )
    # Associate auteurs with the document
    auteur.documents << documents
    # Enregistrement de l'instance en base de données
    if auteur.save
        puts "auteur enregistré avec succès : #{auteur.inspect}"
    else
        puts "Erreur lors de l'enregistrement de l'auteur : #{auteur.errors.full_messages.join(', ')}"
    end
    end
end
  
def destroy
    @auteur.destroy
    respond_to do |format|
      format.html { redirect_to auteurs_url, notice: "Auteur was successfully destroyed." }
      format.json { head :no_content }
    end
end

  private
    def set_auteur
      @documents = Document.all
      @auteur = Auteur.find(params[:id])
    end

    def auteur_params
      params.require(:auteur).permit(:nom_prenom)
    end
end
