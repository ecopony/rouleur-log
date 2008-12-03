require File.dirname(__FILE__) + '/../../spec_helper'

describe "/rides/show.html.erb" do
  include RidesHelper
  
  before(:each) do
    
    bike = mock_model(Bike)
    bike.stub!(:name).and_return("Giant")
    
    route = mock_model(Route)
    route.stub!(:name).and_return("River")
    
    ride_type = mock_model(RideType)
    ride_type.stub!(:name).and_return("Road")
    
    @ride = mock_model(Ride)
    @ride.stub!(:distance).and_return("MyString")
    @ride.stub!(:time).and_return("MyString")
    @ride.stub!(:average_speed).and_return("MyString")
    @ride.stub!(:bike).and_return(bike)
    @ride.stub!(:route).and_return(route)
    @ride.stub!(:ride_on).and_return(Date.today)
    @ride.stub!(:ride_type).and_return(ride_type)
    
    

    assigns[:ride] = @ride
  end

  it "should render attributes in <p>" do
    render "/rides/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

