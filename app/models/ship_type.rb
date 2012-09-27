class ShipType < ActiveRecord::Base
  attr_accessible :name, :size, :starting_quantity

  validates_presence_of :name, :size, :starting_quantity
  validates_numericality_of :size, :starting_quantity

  # Return the prefix of the ship for display purposes on the board
  def prefix
    name[0].capitalize
  end

end