require 'spec_helper'

describe Ship do

  subject { create(:ship) }

  it "has a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :board_id }
  it { should validate_presence_of :ship_type_id }

  it { should belong_to(:board) }
  it { should belong_to(:ship_type) }
  it { should have_many(:co_ordinates)}

  describe "#size" do
    it "should delegate size method call to ship type" do
      should respond_to(:size)
    end
  end

  describe "#place_on_board" do
    it "should place itself successfully on the board it belongs to" do
      ship = create(:ship)
      ship.place_on_board
      ship.co_ordinates.count.should == ship.ship_type.size
    end
  end
end
