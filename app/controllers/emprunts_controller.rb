class EmpruntsController < ApplicationController
  before_action :set_emprunt, only: %i[ show edit update destroy ]
  def index
    sql_ordinateur = "SELECT 
      `emprunts`.`id` AS emprunt_id,
      `materiels`.`nom` AS materiel_name,
      `materiels`.`id` AS materiel_id,
      `adherents`.`nom` as ad_nom, 
      `adherents`.`prenom` ad_prenom, 
      `emprunts`.`created_at` as created_at
      from emprunts 
      LEFT JOIN emprunt_materiels ON emprunts.id=`emprunt_materiels`.`emprtunt_id` 
      LEFT JOIN materiels ON materiels.id=emprunt_materiels.materiel_id 
      LEFT JOIN adherents ON adherents.id=emprunts.adherent_id 
      WHERE emprunts.id NOT NULL 
      AND `emprunt_materiels`. `materiel_id` NOT NULL
      "

    sql_document = "SELECT 
      `emprunts`.`id` AS emprunt_id,
      `documents`.`titre` AS document_name,
      `documents`.`id` AS document_id,
      `adherents`.`nom` as ad_nom, 
      `adherents`.`prenom` ad_prenom, 
      `emprunts`.`created_at` as created_at
      from emprunts 
      LEFT JOIN emprunt_documents ON emprunts.id=`emprunt_documents`.`emprtunt_id` 
      LEFT JOIN documents ON documents.id=emprunt_documents.document_id 
      LEFT JOIN adherents ON adherents.id=emprunts.adherent_id 
      WHERE emprunts.id NOT NULL 
      AND `emprunt_documents`. `document_id` NOT NULL
      "
    @emprunt_ordinateur = ActiveRecord::Base.connection.execute(sql_ordinateur) 
    @emprunt_documents = ActiveRecord::Base.connection.execute(sql_document) 
    @emprunts = Emprunt.all
  end

  def show
    @materiels = Materiel.all
    @documents = Document.all
    @adherents = Adherent.all
    id = request.url.split("/")[4]
    sql_ordinateur = "SELECT 
    `emprunts`.`id` AS emprunt_id,
    `materiels`.`nom` AS materiel_name,
    `materiels`.`id` AS materiel_id,
    `adherents`.`nom` as ad_nom, 
    `adherents`.`prenom` ad_prenom, 
    `adherents`.`id` adherent_id, 
    `emprunts`.`created_at` as created_at
    from emprunts 
    LEFT JOIN emprunt_materiels ON emprunts.id=`emprunt_materiels`.`emprtunt_id` 
    LEFT JOIN materiels ON materiels.id=emprunt_materiels.materiel_id 
    LEFT JOIN adherents ON adherents.id=emprunts.adherent_id 
    WHERE emprunts.id=#{id} LIMIT 1
     "
     @is_ordinateur = true
     @emp = ActiveRecord::Base.connection.execute(sql_ordinateur) 
     if(@emp.nil?)
        @is_ordinateur = false
        sql_document = "SELECT 
        `emprunts`.`id` AS emprunt_id,
        `documents`.`titre` AS document_name,
        `documents`.`id` AS document_id,
        `adherents`.`nom` as ad_nom, 
        `adherents`.`prenom` ad_prenom, 
        `adherents`.`id` adherent_id, 
        `emprunts`.`created_at` as created_at
        from emprunts 
        LEFT JOIN emprunt_documents ON emprunts.id=`emprunt_documents`.`emprtunt_id` 
        LEFT JOIN documents ON documents.id=emprunt_documents.document_id 
        LEFT JOIN adherents ON adherents.id=emprunts.adherent_id 
        WHERE emprunts.id=#{id}
        LIMIT 1
        "
        @emp = ActiveRecord::Base.connection.execute(sql_document) 
        @is_document = true
     end
  end

  def new
    @is_edit = false
    @adherents = Adherent.all
    @emprunt = Emprunt.new

    if(params[:type].nil?)
      return
    end
    if(params[:type] == 'Ordinateur')
      @is_ordinateur = true
      @is_document = false
      @ordinateurs = getOrdinateurs()
      return
    else
      @is_ordinateur = false
      @is_document = true
      @documents = getDocuments()
    end
  end

  def getOrdinateurs()
    ordinateur = Materiel.all.where("mat_type='Ordinateur'")
    return ordinateur
  end

  def getDocuments()
    documents = Document.all
    return documents
  end

  def edit
    @materiels = Materiel.all
    @documents = Document.all
    @adherents = Adherent.all
  end

  def create
    @emprunt = Emprunt.new(emprunt_params)
    doc_id = params[:doc_id]
    mat_id = params[:mat_id]
    if(mat_id.nil? && doc_id.nil?)
      return
    end
    respond_to do |format|
      if @emprunt.save
        if(doc_id)
          inserts = [@emprunt.id, Integer(doc_id)]
          sql = "INSERT INTO emprunt_documents(emprtunt_id, document_id) VALUES(#{inserts.join(", ")})"
          ActiveRecord::Base.connection.execute(sql) 
        end
        if(mat_id)
          inserts = [@emprunt.id, Integer(mat_id)]
          sql = "INSERT INTO emprunt_materiels('emprtunt_id', 'materiel_id') VALUES(#{inserts.join(", ")})"
          ActiveRecord::Base.connection.execute(sql) 
        end
        format.html { redirect_to emprunt_url(@emprunt), notice: "Emprunt was successfully created." }
        format.json { render :show, status: :created, location: @emprunt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @emprunt.errors, status: :unprocessable_entity }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_emprunt
      @emprunt = Emprunt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def emprunt_params
      params.require(:emprunt).permit(:adherent_id)
    end
end
