class CreateJoinTableEmpruntsMateriels < ActiveRecord::Migration[7.0]
  def change
    create_join_table :emprunts, :materiels do |t|
      # t.index [:emprunt_id, :materiel_id]
      # t.index [:materiel_id, :emprunt_id]
    end
  end
end
