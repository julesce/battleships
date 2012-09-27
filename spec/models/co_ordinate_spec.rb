require 'spec_helper'

describe CoOrdinate do

  subject { create(:co_ordinate) }

  it "has a valid factory" do
    should be_valid
  end

  it { should validate_presence_of :parent_id }
  it { should validate_presence_of :parent_type }
  it { should validate_presence_of :x }
  it { should validate_presence_of :y }

end
