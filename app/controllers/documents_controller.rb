class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  $document_auteurs = []
  $query = ''

  def index
    if(params[:query].nil?)
      @documents = Document.all
      return
    end

    query = params[:query]
    @documents = search(query)
  end

  def show
    id = request.url.split("/")[4]
    @auteurs = getDocumentAuteurs(id)
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
  def getDocumentAuteurs(id)
    document_auteurs = Auteur.all.joins("LEFT JOIN document_auteurs ON auteurs.id=document_auteurs.auteur_id").where("document_auteurs.document_id=:id", id: Integer(id))
    return document_auteurs
  end

  def getAuteurs()
    return Auteur.all
  end
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
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
    respond_to do |format|
      id = params[:auteur_id]
      if(id)
        inserts = [@document.id, id]
        sql = "INSERT INTO document_auteurs('document_id', 'auteur_id') VALUES(#{inserts.join(", ")})"
        ActiveRecord::Base.connection.execute(sql) 
      end
      if @document.update(document_params)
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

  private
    def set_document
      @document = Document.find(params[:id])
    end
    def document_params
      params.require(:document).permit(:doc_type, :titre, :isbn)
    end
end
