class Game < ActiveRecord::Base

  after_create :initialize_game

  has_many :boards

  validates_presence_of :name, :email

  attr_accessible :name, :email

  # Return the player board
  def player_board
    boards.player.first
  end

  # Return the opponent board
  def opponent_board
    boards.opponent.first
  end

  # Fire a shot and then determine the return shot
  def fire_shot(x, y)
    opponent_board.take_shot(x, y)
    opponent_board.fire_shot_on_board(player_board)
  end

  def status
    @status ||= determine_status
  end

  # P R I V A T E
  private

  # Initialize the game by setting up the boards
  def initialize_game
    setup_boards
  end

  # Initialise the boards
  def setup_boards
    init_player_board
    init_opponent_board
  end

  # Initialise the player board and place the ships
  def init_player_board
    board = Board.create_player_board(self.id)
    board.place_ships
  end

  # Initialise the opponent board
  def init_opponent_board
    board = Board.create_opponent_board(self.id)
    board.place_ships
  end

  # Return the status of the game, depending on whether or not all ships are sunk for a given board.
  def determine_status
    if opponent_board.present? and opponent_board.all_ships_are_sunk?
      "You Win! Congratulations!"
    elsif player_board.present? and player_board.all_ships_are_sunk?
      "You Lose! Better luck next time..."
    end
  end

  ## Handle the response from sending the 'nuke' message to the server
  #def handle_fire_shot_response(x, y, response)
  #  @last_response = response
  #
  #  is_hit = (response.status == 'hit') ? true : false
  #  opponent_board.fire_shot(x, y, is_hit)
  #
  #  if response.x.present? and response.y.present?
  #    player_board.take_shot(response.x, response.y)
  #  end
  #end

end
