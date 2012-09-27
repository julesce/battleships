class Board < ActiveRecord::Base

  TYPES = %w(player opponent)

  attr_accessible :game_id, :size, :type_of

  belongs_to :game
  has_many :ships
  has_many :shots

  validates_presence_of :game_id, :size, :type_of
  validates_inclusion_of :type_of, :in => TYPES

  scope :player, where(:type_of => 'player')
  scope :opponent, where(:type_of => 'opponent')

  class << self
    def create_player_board(game_id)
      create(:game_id => game_id, :type_of => 'player')
    end

    def create_opponent_board(game_id)
      create(:game_id => game_id, :type_of => 'opponent')
    end
  end

  # Return true/false if this board is of type 'opponent'
  def is_opponent?
    type_of == 'opponent'
  end

  # Return the most recent shot on the board
  def most_recent_shot
    @recent_shot ||= shots.order('created_at').last
  end

  # Fire a shot at the enemy
  def fire_shot(x, y, is_hit = false)
    shot = shot_at_co_ordinate(x, y)
    if shot.blank?
      shot = shots.create(:is_hit => is_hit)
      shot.co_ordinates.create(:x => x, :y => y)
    end
  end

  # Fire a shot at the opponent board, taking into account existing shots fired
  def fire_shot_on_board(board)
    shot = board.random_open_shot_co_ordinate
    board.take_shot(shot.x, shot.y)
  end

  # Take a shot from the enemy
  def take_shot(x, y)
    ship = ship_at_co_ordinate(x, y)
    fire_shot(x, y, (ship.present?) ? true : false)
  end

  # Figure out if all ships are sunk on the board
  def all_ships_are_sunk?
    shots_array = []
    shots.where(:is_hit => true).each do |shot|
      shots_array << {:x => shot.x , :y => shot.y}
    end

    ships_array = []
    ship_co_ordinates_in_use.each do |ship_co_ordinate|
      ships_array << {:x => ship_co_ordinate.x, :y => ship_co_ordinate.y}
    end

    # If this returns an empty array then it means that all items matched, and that the ships have been sunk
    xor(shots_array, ships_array).blank?
  end

  # Randomly place the ships on the board
  def place_ships
    ShipType.all.each do |type|
      type.starting_quantity.times do
        ship = Ship.create(:board_id => self.id, :ship_type_id => type.id)
        ship.place_on_board
      end
    end
  end

  # Return a random co ordinate that is not in use by any ships on the board
  def random_open_ship_co_ordinate
    x, y = nil
    not_found = true

    while not_found
      x = rand(self.size)
      y = rand(self.size)

      if is_safe_ship_co_ordinate(x, y)
        not_found = false
      end
    end

    CoOrdinate.new(:x => x, :y => y)
  end

  # Are the co-ordinates in use by any ships?
  def is_safe_ship_co_ordinate(x, y)
    (ship_co_ordinates_in_use.index {|a| a.x == x && a.y == y} == nil) ? true : false
  end

  # An array of co-ordinates that are in use by ships on the board
  def ship_co_ordinates_in_use
    if @ship_co_ords_in_use.blank?
      @ship_co_ords_in_use = []
      ships.each do |ship|
        @ship_co_ords_in_use = @ship_co_ords_in_use | ship.co_ordinates.all
      end
    end
    @ship_co_ords_in_use
  end

  # Returns the ship at the given co-ordinates
  def ship_at_co_ordinate(x, y)
    ship = nil
    ships.each do |s|
      if s.co_ordinates.index {|a| a.x == x && a.y == y}
        ship = s
        break
      end
    end
    ship
  end

  # Returns the shot at the given co-ordinates
  def shot_at_co_ordinate(x, y)
    shot = nil
    shots.each do |s|
      if s.co_ordinates.index {|a| a.x == x && a.y == y}
        shot = s
        break
      end
    end
    shot
  end

  # Return a random co ordinate that is not in use by any ships on the board
  def random_open_shot_co_ordinate
    x, y = nil
    not_found = true

    while not_found
      x = rand(self.size)
      y = rand(self.size)

      if is_safe_shot_co_ordinate(x, y)
        not_found = false
      end
    end

    CoOrdinate.new(:x => x, :y => y)
  end

  # P R I V A T E
  private

  # 'exclusive or' helper method for array matching
  def xor(a, b)
    (a | b) - (a & b)
  end



  # An array of co-ordinates that are in use by shots on the board
  def shot_co_ordinates_in_use
    if @shot_co_ords_in_use.blank?
      @shot_co_ords_in_use = []
      shots.each do |shot|
        @shot_co_ords_in_use = @shot_co_ords_in_use | shot.co_ordinates.all
      end
    end
    @shot_co_ords_in_use
  end

  # Are the co-ordinates in use by any shots?
  def is_safe_shot_co_ordinate(x, y)
    (shot_co_ordinates_in_use.index {|a| a.x == x && a.y == y} == nil) ? true : false
  end

end
