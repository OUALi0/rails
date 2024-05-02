class CreateAuteurs < ActiveRecord::Migration[7.0]
  def change
    create_table :auteurs do |t|
      t.string :nom_prenom
      t.integer :document_id
      t.timestamps
    end
  end
end
