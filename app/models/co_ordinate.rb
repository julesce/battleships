class CoOrdinate < ActiveRecord::Base
  attr_accessible :x, :y

  belongs_to :parent, :polymorphic => true
  
  validates_presence_of :x, :y, :parent_id, :parent_type
  validates_numericality_of :x, :y

end
