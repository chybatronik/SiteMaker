class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name_file
      t.string :layout
      t.string :permalink
      t.boolean :published
      t.text :categories
      t.text :tags
      t.string :title
      t.text :content
      t.string :date
      t.integer :site_id

      t.timestamps
    end
  end
end
