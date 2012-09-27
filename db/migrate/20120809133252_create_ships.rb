class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.integer :ship_type_id, :nil => false
      t.integer :board_id, :nil => false
      t.boolean :is_sunk, :nil => false, :default => false

      t.timestamps
    end

    add_index :ships, :ship_type_id
    add_index :ships, :board_id
  end
end
