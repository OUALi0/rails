class DocumentsController < ApplicationController
  before_action :set_document, only: %i[ show edit update destroy ]
  $document_auteurs = []
  $query = ''

  # GET /documents or /documents.json
  def index
    if(params[:query].nil?)
      @documents = Document.all
      return
    end

    query = params[:query]
    @documents = search(query)
  end

  # GET /documents/1 or /documents/1.json
  def show
    id = request.url.split("/")[4]
    @auteurs = getDocumentAuteurs(id)
  end

  # GET /documents/new
  def new
    @is_edit = false
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
    @is_edit = true
    @auteurs = getAuteurs()
  end

  def getDocumentAuteurs(id)
    document_auteurs = Auteur.all.joins("LEFT JOIN document_auteurs ON auteurs.id=document_auteurs.auteur_id").where("document_auteurs.document_id=:id", id: Integer(id))
    # ids = document_auteurs.map{ |auteur| auter.aut}
    return document_auteurs
  end

  def getAuteurs()
    return Auteur.all
  end

  # POST /documents or /documents.json
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


  # PATCH/PUT /documents/1 or /documents/1.json
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

  # DELETE /documents/1 or /documents/1.json
  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to documents_url, notice: "Document was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def document_params
      params.require(:document).permit(:doc_type, :titre, :isbn)
    end
end
