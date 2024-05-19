class MaterielsController < ApplicationController
  before_action :set_materiel, only: %i[ show edit update destroy ]
  def index
    @materiels = Materiel.all
  end
  def show
  end
  def new
    @materiel = Materiel.new
  end
  def edit
  end
  def create
    @materiel = Materiel.new(materiel_params)
    respond_to do |format|
      if @materiel.save
        format.html { redirect_to materiel_url(@materiel), notice: "Materiel was successfully created." }
        format.json { render :show, status: :created, location: @materiel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materiel.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @materiel.update(materiel_params)
        format.html { redirect_to materiel_url(@materiel), notice: "Materiel was successfully updated." }
        format.json { render :show, status: :ok, location: @materiel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materiel.errors, status: :unprocessable_entity }
      end
    end
  end

  def charger_table
    require 'csv'
      csv_file_path = 'C:\Users\OUALID\Downloads\materiels.csv'
      # Lecture du fichier CSV
      CSV.foreach(csv_file_path, headers: true) do |row|
          puts row.inspect
      # Création d'une nouvelle instance de materiel avec les attributs du CSV
      materiel = Materiel.new(
          id: row['ID'],
          mat_type: row['TYPE'],
          nom: row['NOM']
      )
      # Enregistrement de l'instance en base de données
      if materiel.save
          puts "materiel enregistré avec succès : #{materiel.inspect}"
      else
          puts "Erreur lors de l'enregistrement de l'materiel : #{materiel.errors.full_messages.join(', ')}"
      end
      end
  end
  def destroy
    @materiel.destroy

    respond_to do |format|
      format.html { redirect_to materiels_url, notice: "Materiel was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    def set_materiel
      @materiel = Materiel.find(params[:id])
    end
    def materiel_params
      params.require(:materiel).permit(:mat_type, :nom)
    end
end
