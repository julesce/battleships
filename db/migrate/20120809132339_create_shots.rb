class CreateShots < ActiveRecord::Migration
  def change
    create_table :shots do |t|
      t.integer :board_id, :nil => false
      t.integer :x, :nil => false
      t.integer :y, :nil => false
      t.boolean :is_hit

      t.timestamps
    end

    add_index :shots, :board_id
  end
end
