class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :game_id, :nil => false
      t.integer :size, :nil => false, :default => 10
      t.string :type_of, :nil => false
      t.timestamps
    end

    add_index :boards, :game_id
    add_index :boards, :type_of
  end
end
