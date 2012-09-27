class Shot < ActiveRecord::Base
  attr_accessible :board_id, :is_hit

  belongs_to :board
  has_many :co_ordinates, :as => :parent

  validates_presence_of :board_id

  def x
    co_ordinates.present? ? co_ordinates.first.x : nil
  end

  def y
    co_ordinates.present? ? co_ordinates.first.y : nil
  end
end
