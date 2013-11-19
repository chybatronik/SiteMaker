class AddConfirmableToDeviseV1 < ActiveRecord::Migration
  def change
    change_table(:users) do |t| 
      t.boolean :confirmable, :default => false
    end
    add_index  :users, :confirmation_token, :unique => true 
  end
end
