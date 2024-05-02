class MaterielsController < ApplicationController
  before_action :set_materiel, only: %i[ show edit update destroy ]

  # GET /materiels or /materiels.json
  def index
    @materiels = Materiel.all
  end

  # GET /materiels/1 or /materiels/1.json
  def show
  end

  # GET /materiels/new
  def new
    @materiel = Materiel.new
  end

  # GET /materiels/1/edit
  def edit
  end

  # POST /materiels or /materiels.json
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

  # PATCH/PUT /materiels/1 or /materiels/1.json
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

  # DELETE /materiels/1 or /materiels/1.json
  def destroy
    @materiel.destroy

    respond_to do |format|
      format.html { redirect_to materiels_url, notice: "Materiel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materiel
      @materiel = Materiel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def materiel_params
      params.require(:materiel).permit(:mat_type, :nom)
    end
end
