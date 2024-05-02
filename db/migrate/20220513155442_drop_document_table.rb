class DropDocumentTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :documents
  end
end
