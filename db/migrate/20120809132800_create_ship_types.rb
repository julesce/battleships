class CreateShipTypes < ActiveRecord::Migration
  def change
    create_table :ship_types do |t|
      t.string :name, :nil => false
      t.integer :size, :nil => false
      t.integer :starting_quantity, :nil => false
      t.timestamps
    end
  end
end
