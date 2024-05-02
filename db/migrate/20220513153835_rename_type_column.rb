class RenameTypeColumn < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :documents, :type, :new_column
  end

  def self.down
    rename_column :documents, :new_column, :type
  end
end
