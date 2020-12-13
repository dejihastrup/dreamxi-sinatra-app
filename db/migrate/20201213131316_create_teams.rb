class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :formation
      t.string :user_id
      
      t.timestamps null: false
    end
  end
end
