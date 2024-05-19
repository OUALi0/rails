class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  $query = ''

  def index
    @auteurs = getAuteurs()
    @documents = Document.all
  
  if params[:auteur_id].present?
    @auteur = Auteur.find(params[:auteur_id])
    @documents = @auteur.documents
  end
    if(params[:query].nil?)
      @documents = Document.all
      return
    end
    query = params[:query]
    @documents = search(query)
  end

  def show
    @auteurs = getAuteurs()
    @documents = Document.all
    if params[:auteur_id].present?
      @auteur = Auteur.find(params[:auteur_id])
      @documents = @auteur.documents
    end
  end

  def new
    @is_edit = false
    @auteurs = getAuteurs()
    @document = Document.new
  end

  def edit
    @is_edit = true
    @auteurs = getAuteurs()
  end
  def getAuteurs()
    return Auteur.all
  end
  def create
    @auteurs = getAuteurs()
    @document = Document.new(document_params)
    # Assuming you have a parameter named :auteur_id in your form
    @auteur = Auteur.find(params[:auteur_id])
    respond_to do |format|
      if @document.save
        # Associate the document with the auteur
        @auteur.documents << @document
        format.html { redirect_to document_url(@document), notice: "Document was successfully created." }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def search(query)
    res = Document.all.where("lower(titre) LIKE :search", search:"%#{query}%")
    return res
  end

  def update
    @auteurs = getAuteurs()
    respond_to do |format|
      # Assuming you have a parameter named :auteur_id in your form
      @auteur = Auteur.find(params[:auteur_id])
      if @document.update(document_params)
        @auteur.documents << @document
        format.html { redirect_to document_url(@document), notice: "Document was successfully updated." }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  require 'csv'
  def charger_table
    csv_file_path = 'C:\Users\OUALID\Downloads\documents.csv'
    # Lecture du fichier CSV
    CSV.foreach(csv_file_path, headers: true) do |row|
      # Extracting author names
      auteurs_names = row['Auteur'].split(',').map(&:strip)
  
      # Find or create authors
      auteurs = []
      auteurs_names.each do |auteur_name|
        auteur = Auteur.find_or_create_by(nom_prenom: auteur_name)
        auteurs << auteur
      end
      # Création d'une nouvelle instance de document avec les attributs du CSV
      document = Document.new(
        id: row['ID'],
        doc_type: row['TYPE'],
        titre: row['TITRE'],
        isbn: row['ISBN']
      )
      # Associate auteurs with the document
      document.auteurs << auteurs
      # Enregistrement de l'instance en base de données
      if document.save
          puts "document enregistré avec succès : #{document.inspect}"
      else
          puts "Erreur lors de l'enregistrement de l'document : #{document.errors.full_messages.join(', ')}"
      end
      end
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end
    def document_params
      params.require(:document).permit(:doc_type, :titre, :isbn)
    end
end
