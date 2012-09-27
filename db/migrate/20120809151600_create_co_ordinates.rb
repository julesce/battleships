class CreateCoOrdinates < ActiveRecord::Migration
  def change
    create_table :co_ordinates do |t|
      t.integer :x, :nil => false
      t.integer :y, :nil => false
      t.references :parent, :polymorphic => true

      t.timestamps
    end
  end
end
