class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, :nil => false
      t.string :email, :nil => false
      t.timestamps
    end
  end
end
