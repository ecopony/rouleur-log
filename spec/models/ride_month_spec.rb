require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RideMonth do
  before(:each) do
    @valid_attributes = {
      :month => 1,
      :year => 1,
      :distance => 1.5,
      :ride_count => 1,
    }
  end

  it "should create a new instance given valid attributes" do
    ride_month = RideMonth.new(@valid_attributes)
    ride_month.user_id = 1
    ride_month.save!
  end

end
