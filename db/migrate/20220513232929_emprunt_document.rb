class EmpruntDocument < ActiveRecord::Migration[7.0]
  def change
    create_table :emprunt_documents do |t|
      t.integer :emprtunt_id
      t.integer :document_id
    end
  end
end
