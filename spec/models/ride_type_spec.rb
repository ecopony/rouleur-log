require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RideType do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :is_commute => false
    }
  end

  it "should create a new instance given valid attributes" do
    RideType.create!(@valid_attributes)
  end
end
