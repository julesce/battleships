require 'spec_helper'

describe Board do

  before(:all) do
    # Run the seed_fu task to generate the ship types required for the ships
    SeedFu.seed
  end

  subject { create(:board) }

  it "has a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :game_id }
  it { should validate_presence_of :size }
  it { should validate_presence_of :type_of }
  it { should ensure_inclusion_of(:type_of).in_array(Board::TYPES) }

  it { should belong_to(:game) }
  it { should have_many(:ships)}
  it { should have_many(:shots)}

  describe "player and opponent boards" do
    before(:all) do
      @game = create(:game)
    end
    describe ".create_player_board" do
      it "should return a new player board" do
        board = Board.create_player_board(@game.id)
        board.type_of.should == 'player'
      end
    end

    describe ".create_opponent_board" do
      it "should return a new opponent board" do
        board = Board.create_opponent_board(@game.id)
        board.type_of.should == 'opponent'
      end
    end

    describe "#is_opponent?" do
      it "should return true if it is an opponent board" do
        board = Board.create_opponent_board(@game.id)
        board.should be_is_opponent
      end
    end
  end

  describe "#most_recent_shot" do
    it "should return the most recent shot on the board" do
      board = create(:board_with_shots)
      board.most_recent_shot.id.should == board.shots.order('created_at').last.id
    end
  end

  describe "#fire_shot" do
    it "should create a shot on the board at the given co-ordinates" do
      board = create(:board)
      board.fire_shot(1, 1, true)
      shot = board.shot_at_co_ordinate(1, 1)
      shot.co_ordinates.index {|a| a.x == 1 && a.y == 1}.should_not be_nil
    end
  end

  describe "#fire_shot_on_board" do
    it "should fire a shot on the board that is supplied" do
      board = create(:board)
      opponent_board = create(:board)
      shot_count = opponent_board.shots.count
      board.fire_shot_on_board(opponent_board)
      opponent_board.shots.count.should == shot_count + 1
    end
  end

  describe "#take_shot" do
    it "should create a shot and determine whether or not the shot was a 'hit' or not" do
      board = create(:board)
      board.take_shot(1, 1)
      board.shot_at_co_ordinate(1, 1).should be_present
    end
  end

  describe "#place_ships" do
    it "should create and place the ships based on the ship types available" do
      board = create(:board)
      board.place_ships
      board.ships.should be_present
    end
  end

  describe "#random_open_ship_co_ordinate" do
    it "should return a random open co-ordinate" do
      board = create(:board)
      co_ordinate = board.random_open_ship_co_ordinate
      co_ordinate.should be_present
    end
  end

  describe "#is_safe_ship_co_ordinate" do
    it "should return true if a co-ordinate is already in use by a ship" do
      board = create(:board)
      board.place_ships
      ship = board.ships.first
      x = ship.co_ordinates.first.x
      y = ship.co_ordinates.first.y
      board.is_safe_ship_co_ordinate(x, y).should be_false
    end

    it "should return false if a co-ordinate is not in use by a ship" do
      board = create(:board)
      board.is_safe_ship_co_ordinate(1, 1).should be_true
    end
  end

  describe "#ship_co_ordinates_in_use" do
    it "should return the an array of co-ordinates that are in use by ships" do
      board = create(:board)
      board.place_ships
      board.ship_co_ordinates_in_use.should be_present
    end
  end

  describe "#ship_at_co_ordinate" do
    it "should return the ship at a given co-ordinate" do
      board = create(:board)
      board.place_ships
      ship = board.ships.first
      x = ship.co_ordinates.first.x
      y = ship.co_ordinates.first.y
      board.ship_at_co_ordinate(x, y).should == ship
    end
  end

  describe "#shot_at_co_ordinate" do
    it "should return the shot at a given co-ordinate" do
      board = create(:board)
      board.fire_shot(1, 1)
      shot = board.shot_at_co_ordinate(1, 1)
      shot.x.should == 1
      shot.y.should == 1
    end
  end

end