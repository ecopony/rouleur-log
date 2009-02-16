require File.dirname(__FILE__) + '/../spec_helper'

describe Ride do
  before(:each) do
    
    @bike = Bike.new({:name => "Giant"})
    @bike.save!
    
    route = Route.new({:name => "River"})
    route.save!
    
    @ride = Ride.new
    @ride.distance = 12.8
    @ride.bike = @bike
    @ride.route = route
    @ride.ride_on = Date.new
  end

  it "should be valid" do
    @ride.should be_valid
  end

  describe "generating ride stats" do

    before(:each) do
      mock_user
      @last_month_ride = Ride.new({ :bike_id => @bike.id, :ride_on => Time.new.advance(:months => -1), :distance => 21 })
      @last_month_ride.user_id = @user.id
      @last_month_ride.save!

      @first_ride_this_month = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new, :distance => 13 })
      @first_ride_this_month.user_id = @user.id
      @first_ride_this_month.save!

      @second_ride_this_month = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new, :distance => 101 })
      @second_ride_this_month.user_id = @user.id
      @second_ride_this_month.save!

      @next_month_ride = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new.advance(:months => 1), :distance => 12 })
      @next_month_ride.user_id = @user.id
      @next_month_ride.save!

      @stats = Ride.month_stats
    end
    
    it "should generate a ride count" do
      @stats[:ride_count].should eql(2)
    end

    it "should generate total miles ridden" do
      @stats[:total_miles].should eql(114.0)
    end

    it "should generate a long ride" do
      @stats[:long_ride].should eql(101.0)
    end

  end

end
