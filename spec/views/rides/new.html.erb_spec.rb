require File.dirname(__FILE__) + '/../../spec_helper'

describe "/rides/new.html.erb" do
  include RidesHelper
  
  before(:each) do
    mock_user
    @ride = mock_model(Ride)
    @ride.stub!(:new_record?).and_return(true)
    @ride.stub!(:distance).and_return("MyString")
    @ride.stub!(:time).and_return("MyString")
    @ride.stub!(:average_speed).and_return("MyString")
    @ride.stub!(:comments).and_return("MyString")
    @ride.stub!(:bike_id).and_return("1")
    @ride.stub!(:route_id).and_return("1")
    @ride.stub!(:ride_on).and_return(Date.today)
    @ride.stub!(:ride_type_id).and_return("1")
    assigns[:user_id] = 1
    assigns[:ride] = @ride
  end

  it "should render new form" do
    render "/rides/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", rides_path) do
      with_tag("input#ride_distance[name=?]", "ride[distance]")
      with_tag("input#ride_time[name=?]", "ride[time]")
      with_tag("input#ride_average_speed[name=?]", "ride[average_speed]")
    end
  end
end


