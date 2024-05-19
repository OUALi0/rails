class RemoveDocumentIdFromAuteur < ActiveRecord::Migration[7.0]
  def change
    remove_column :auteurs, :document_id, :integer
  end
end
