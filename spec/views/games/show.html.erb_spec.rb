require 'spec_helper'

describe "games/show" do
  before(:each) do
    @game = assign(:game, stub_model(Game, :id => 99, :name => 'James', :email => 'me@example.com'))
    render
  end

  it "renders id in <h1>" do
    assert_select "h1", :content => "Game #99"
  end

end
