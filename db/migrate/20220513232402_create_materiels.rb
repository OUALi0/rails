class CreateMateriels < ActiveRecord::Migration[7.0]
  def change
    create_table :materiels do |t|
      t.string :mat_type
      t.string :nom

      t.timestamps
    end
  end
end
