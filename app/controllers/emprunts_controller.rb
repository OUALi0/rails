class EmpruntsController < ApplicationController
  before_action :set_emprunt, only: %i[ show edit update destroy ]
  def index
    if params[:query].present?
      @emprunts = search(params[:query])
      @auteurs = search(params[:query])
    else
      @emprunts = Emprunt.includes(:materiels, :documents, :adherent).all
      @auteurs = Auteur.includes(:documents).all
      @emprunts_documents = Emprunt.joins(:documents).distinct
      @emprunts_materiels = Emprunt.joins(:materiels).distinct
      
    end
    @materiels = Materiel.all
    @documents = Document.all
    @adherents = Adherent.all
  end
  def show
    @materiels = Materiel.all
    @documents = Document.all
    if @emprunt.adherent_id.present?
      @adherent = Adherent.find_by(id: @emprunt.adherent_id)
    else
      @adherent = nil
    end
    if params[:document_id].present?
      @document = Document.find(params[:document_id])
      @emprunts = @document.emprunts
    elsif params[:materiel_id].present?
      @materiel = Materiel.find(params[:materiel_id])
      @emprunts = @materiel.emprunts
    else
      @emprunts = [@emprunt]
    end
  end
  

  def new
    @is_edit = false
    @adherents = Adherent.all
    @emprunt = Emprunt.new
    @materiels = Materiel.all
    @documents = Document.all
    @is_ordinateur = params[:type] == 'Ordinateur'
    @is_document = params[:type] == 'Document'
  end

  def edit
    @materiels = Materiel.all
    @documents = Document.all
    @adherents = Adherent.all
  end

  def create
    @emprunt = Emprunt.new(emprunt_params)
    document_id = params[:document_id]
    materiel_id = params[:materiel_id]
    respond_to do |format|
      if @emprunt.save
        if document_id.present?
          @document = Document.find_by(id: document_id)
          @document.emprunts << @emprunt if @document
          format.html { redirect_to emprunt_url(@emprunt), notice: "Emprunt was successfully created." }
          format.json { render :show, status: :created, location: @emprunt }
        elsif materiel_id.present?
          @materiel = Materiel.find_by(id: materiel_id)
          @materiel.emprunts << @emprunt if @materiel
          format.html { redirect_to emprunt_url(@emprunt), notice: "Emprunt was successfully created." }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @emprunt.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @emprunt.update(emprunt_params)
        format.html { redirect_to emprunt_url(@emprunt), notice: "Emprunt was successfully updated." }
        format.json { render :show, status: :ok, location: @emprunt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @emprunt.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @emprunt.destroy
    respond_to do |format|
      format.html { redirect_to emprunts_url, notice: "Emprunt was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_emprunt
      @emprunt = Emprunt.find(params[:id])
    end

    def emprunt_params
      params.require(:emprunt).permit(:adherent_id, :document_id, :materiel_id)
    end
end
