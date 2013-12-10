class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.string :ancestry
      t.integer :site_id

      t.timestamps
    end
    add_index :directories, :ancestry 
    add_index :directories, :site_id
  end
end
