class CreateJoinTableEmpruntsDocuments < ActiveRecord::Migration[7.0]
  def change
    create_join_table :emprunts, :documents do |t|
      # t.index [:emprunt_id, :document_id]
      # t.index [:document_id, :emprunt_id]
    end
  end
end
