require File.dirname(__FILE__) + '/../spec_helper'

describe Route do
  before(:each) do
    @route = Route.new
    @route.name = "River"
  end

  it "should be valid" do
    @route.should be_valid
  end
end
