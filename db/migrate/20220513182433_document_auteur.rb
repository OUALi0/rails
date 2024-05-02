class DocumentAuteurs < ActiveRecord::Migration[7.0]
  def change
    create_table :document_auteurs do |t|
      t.integer :document_id
      t.integer :auteur_id
    end
  end
end
