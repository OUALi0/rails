class AdherentsController < ApplicationController
  before_action :set_adherent, only: %i[ show edit update destroy ]
  $search_triggered = false
  $adherents = []
  $query = ''
  def index
    if(params[:query].nil?)
      $adherents = Adherent.all
      return
    end
    query = params[:query]
    $adherents = search(query)
  end
  def show
  end
  def new
    @adherent = Adherent.new
  end
  def edit
  end
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
  def charger_table
    require 'csv'

    csv_file_path = 'C:\Users\OUALID\Downloads\adherents.csv'

    # Lecture du fichier CSV
    CSV.foreach(csv_file_path, headers: true) do |row|
        puts row.inspect
    # Création d'une nouvelle instance de adherent avec les attributs du CSV
    adherent = Adherent.new(
        id: row['ID'],
        nom: row['NOM'],
        prenom: row['PRENOM']
    )
    # Enregistrement de l'instance en base de données
    if adherent.save
        puts "adherent enregistré avec succès : #{adherent.inspect}"
    else
        puts "Erreur lors de l'enregistrement de l'adherent : #{adherent.errors.full_messages.join(', ')}"
    end
    end
  end

  def destroy
    @adherent.destroy

    respond_to do |format|
      format.html { redirect_to adherents_url, notice: "Adherent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_adherent
      @adherent = Adherent.find(params[:id])
    end
    def adherent_params
      params.require(:adherent).permit(:nom, :prenom, :id)
    end
end
