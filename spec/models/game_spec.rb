require 'spec_helper'

describe Game do

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }

  it { should have_many(:boards)}

  describe "an initialised game object" do
    before(:each) do
      @game = build(:game)
      @game.save
    end

    context "initialization and board setup" do
      describe "#player_board" do
        it "should return a player board" do
          board = @game.player_board
          board.type_of.should == 'player'
        end

        it "should return a player board that has ships" do
          board = @game.player_board
          board.ships.should be_present
        end
      end

      describe "#opponent_board" do
        it "should return an opponent board" do
          board = @game.opponent_board
          board.type_of.should == 'opponent'
        end

        it "should return an opponent board that has ships" do
          board = @game.opponent_board
          board.ships.should be_present
        end
      end

      describe "fire a shot and handle the response" do
        describe "#fire_shot" do
          it "should create a new shot on the opponent board" do
            shot_count = @game.opponent_board.shots.count
            @game.fire_shot(1, 1)
            @game.opponent_board.shots.count.should == shot_count + 1
          end

          it "should create a new shot on the player board based on the x,y that are returned from the AI" do
            shot_count = @game.player_board.shots.count
            @game.fire_shot(1, 1)
            @game.player_board.shots.count.should == shot_count + 1
          end
        end
      end

      describe "#status" do
        it "should return empty status message if game not finished yet" do
          status = @game.status
          status.should be_nil
        end
      end
    end
  end
end
