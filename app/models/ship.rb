class Ship < ActiveRecord::Base
  attr_accessible :board_id, :is_sunk, :ship_type_id

  belongs_to :board
  belongs_to :ship_type
  has_many :co_ordinates, :as => :parent

  validates_presence_of :board_id, :ship_type_id

  delegate :size, :to => :ship_type

  # Place the ship safely on the board based on its size, making sure it doesn't conflict with other ships
  def place_on_board
    is_vertical, co_ordinate = nil
    not_safe = true

    while not_safe do
      # pick random co-ord from list of open co-ordinates
      co_ordinate = board.random_open_ship_co_ordinate

      # pick random orientation
      is_vertical = (rand(2) == 1) ? true : false

      # is it within bounds based on size of board and size of ship?
      if is_co_ordinate_within_bounds?(co_ordinate, is_vertical)

        # now loop through each of co-ordinates based on size, checking against list of open co-ordinates
        conflict_found = false
        size.times do |count|
          if count > 0 # don't bother with first iteration since we've already checked the base co-ordinate
            if is_vertical
              unless board.is_safe_ship_co_ordinate(co_ordinate.x, co_ordinate.y + count)
                conflict_found = true
              end
            else
              unless board.is_safe_ship_co_ordinate(co_ordinate.x + count, co_ordinate.y)
                conflict_found = true
              end
            end
          end
        end

        # If no conflicts found for any co-ordinates then lets exit this loop and save them
        unless conflict_found
          not_safe = false
        end
      end
    end

    # Save each of the co-ordinates for this ship
    save_from_co_ordinate(co_ordinate, is_vertical)
  end

  private

  # Save the co-ordinates for this ship now that we have deemed them safe
  def save_from_co_ordinate(co_ordinate, is_vertical)
    size.times do |count|
      if is_vertical
        self.co_ordinates.create(:x => co_ordinate.x, :y => co_ordinate.y + count)
      else
        self.co_ordinates.create(:x => co_ordinate.x + count, :y => co_ordinate.y)
      end
    end
  end

  # Is the co-ordinate supplied within the bounds of the board?
  def is_co_ordinate_within_bounds?(co_ordinate, is_vertical)
    if is_vertical
      (co_ordinate.y + size <= board.size) ? true : false
    else
      (co_ordinate.x + size <= board.size) ? true : false
    end
  end

end
