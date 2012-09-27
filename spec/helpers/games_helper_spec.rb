require 'spec_helper'

describe GamesHelper do

  describe "#ship_or_shot_prefix" do
    before(:all) do
      # Run the seed_fu task to generate the ship types required for the ships
      SeedFu.seed
    end

    before(:each) do
      @board = create(:board)
      @board.place_ships
    end

    it "should return the prefix for a ship at a given co-ordinate if relevant" do
      ship = @board.ships.first
      co_ord = ship.co_ordinates.first
      helper.ship_or_shot_prefix(@board, co_ord.x, co_ord.y).should == ship.ship_type.prefix
    end

    it "should return the prefix for a shot (hit) if relevant" do
      @board.fire_shot(1, 1, true)
      helper.ship_or_shot_prefix(@board, 1, 1).should == '<strong>X</strong>'
    end

    it "should return the prefix for a shot (miss) if relevant" do
      @board.fire_shot(1, 1, false)
      helper.ship_or_shot_prefix(@board, 1, 1).should == '<strong>O</strong>'
    end

    it "should return an 2 spaces if no shots or ships are available" do
      helper.ship_or_shot_prefix(@board, 9, 9).should == "&nbsp;&nbsp;"
    end
  end

  describe "#data_list_item" do
    it "should return the HTML for a data list item and definition if value is present" do
      helper.data_list_item('label', 'value').should == '<dt>label -</dt><dd>value</dd>'
    end
  end

  describe "#table_cell_click" do
    it "should return the JS method call for the fire_shot function" do
      game = double(:id => 99)
      board = double(:is_opponent? => true)
      helper.table_cell_click(game, board, 4, 8).should == 'fire_shot(99, 4, 8);'
    end
  end

end
