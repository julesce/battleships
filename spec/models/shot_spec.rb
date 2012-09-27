require 'spec_helper'

describe Shot do

  subject(:shot) { create(:shot_with_co_ordinates) }

  it "has a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :board_id }

  it { should belong_to(:board) }
  it { should have_many(:co_ordinates)}

  describe "#x" do
    it "should return the x co-ordinate of the shot" do
      shot.x.should be_present
    end
  end

  describe "#y" do
    it "should return the y co-ordinate of the shot" do
      shot.y.should be_present
    end
  end

end
