require File.dirname(__FILE__) + '/../../spec_helper'

describe "/rides/index.html.erb" do
  include RidesHelper
  
  before(:each) do
    
    bike = mock_model(Bike)
    bike.stub!(:name).and_return("Giant")
    
    route = mock_model(Route)
    route.stub!(:name).and_return("River")
    
    ride_type = mock_model(RideType)
    ride_type.stub!(:name).and_return("Road")
    
    ride_98 = mock_model(Ride)
    ride_98.stub!(:distance).and_return("MyString")
    ride_98.stub!(:time).and_return("MyString")
    ride_98.stub!(:average_speed).and_return("MyString")
    ride_98.stub!(:bike).and_return(bike)
    ride_98.stub!(:route).and_return(route)
    ride_98.stub!(:ride_on).and_return(Date.today)
    ride_98.stub!(:ride_type).and_return(ride_type)
    
    ride_99 = mock_model(Ride)
    ride_99.stub!(:distance).and_return("MyString")
    ride_99.stub!(:time).and_return("MyString")
    ride_99.stub!(:average_speed).and_return("MyString")
    ride_99.stub!(:bike).and_return(bike)
    ride_99.stub!(:route).and_return(route)
    ride_99.stub!(:ride_on).and_return(Date.today)
    ride_99.stub!(:ride_type).and_return(ride_type)

    @rides = [ride_98, ride_99].paginate :page => 1, :per_page => 2
    assigns[:rides] = @rides
    
  end

  it "should render list of rides" do
    render "/rides/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

