class CreateJoinTableAuteursDocuments < ActiveRecord::Migration[7.0]
  def change
    create_join_table :auteurs, :documents do |t|
      # t.index [:auteur_id, :document_id]
      # t.index [:document_id, :auteur_id]
    end
  end
end
