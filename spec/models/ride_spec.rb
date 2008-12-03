require File.dirname(__FILE__) + '/../spec_helper'

describe Ride do
  before(:each) do
    
    bike = Bike.new({:name => "Giant"})
    bike.save!
    
    route = Route.new({:name => "River"})
    route.save!
    
    @ride = Ride.new
    @ride.distance = 12.8
    @ride.bike = bike
    @ride.route = route
    @ride.ride_on = Date.new
  end

  it "should be valid" do
    @ride.should be_valid
  end
end
