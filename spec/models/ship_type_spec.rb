require 'spec_helper'

describe ShipType do

  subject { create(:ship_type) }

  it "should have a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_presence_of :size }
  it { should validate_presence_of :starting_quantity }

  it { should validate_numericality_of :size }
  it { should validate_numericality_of :starting_quantity }

  describe "#prefix" do
    it "should return a prefix of the ship type name" do
      ship_type = create(:ship_type, :name => 'carrier')
      ship_type.prefix.should == 'C'
    end
  end

end
