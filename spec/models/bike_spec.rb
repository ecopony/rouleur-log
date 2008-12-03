require File.dirname(__FILE__) + '/../spec_helper'

describe Bike do
  before(:each) do
    @bike = Bike.new
    @bike.name = "Giant"
  end

  it "should be valid" do
    @bike.should be_valid
  end
end
