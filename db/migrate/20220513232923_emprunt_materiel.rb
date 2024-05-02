class EmpruntMateriel < ActiveRecord::Migration[7.0]
  def change
    create_table :emprunt_materiels do |t|
      t.integer :emprtunt_id
      t.integer :materiel_id
    end
  end
end
