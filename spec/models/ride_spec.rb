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

  describe "generating ride-month data" do

    before(:each) do
      mock_user
      @last_month_ride = Ride.new({ :bike_id => @bike.id, :ride_on => Time.new.advance(:months => -1), :distance => 21 })
      @last_month_ride.user_id = @user.id
      @last_month_ride.save!

      @last_month = @last_month_ride.ride_on.month
      @last_months_year = @last_month_ride.ride_on.year

      @first_ride_this_month = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new, :distance => 13 })
      @first_ride_this_month.user_id = @user.id
      @first_ride_this_month.save!

      @second_ride_this_month = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new, :distance => 101 })
      @second_ride_this_month.user_id = @user.id
      @second_ride_this_month.save!

      @this_month = @first_ride_this_month.ride_on.month
      @this_months_year = @first_ride_this_month.ride_on.year

      @next_month_ride = Ride.create({ :bike_id => @bike.id, :ride_on => Time.new.advance(:months => 1), :distance => 12 })
      @next_month_ride.user_id = @user.id
      @next_month_ride.save!

      @next_month = @next_month_ride.ride_on.month
      @next_months_year = @next_month_ride.ride_on.year
    end

    it 'should have generated ride-month data for last month' do
      ride_month = RideMonth.find_by_month_and_year(@last_month, @last_months_year)
      ride_month.should_not be_nil
      ride_month.month.should == @last_month
      ride_month.year.should == @last_months_year
      ride_month.distance.should == @last_month_ride.distance
      ride_month.ride_count.should == 1
    end

    it 'should have generated ride-month data for this month' do
      ride_month = RideMonth.find_by_month_and_year(@this_month, @this_months_year)
      ride_month.should_not be_nil
      ride_month.month.should == @this_month
      ride_month.year.should == @this_months_year
      ride_month.distance.should == @first_ride_this_month.distance + @second_ride_this_month.distance
      ride_month.ride_count.should == 2
    end

    it 'should have generated ride-month data for next month' do
      ride_month = RideMonth.find_by_month_and_year(@next_month, @next_months_year)
      ride_month.should_not be_nil
      ride_month.month.should == @next_month
      ride_month.year.should == @next_months_year
      ride_month.distance.should == @next_month_ride.distance
      ride_month.ride_count.should == 1
    end

    it "should adjust ride-month distance when an existing ride's distance is updated" do
      new_first_ride_distance = 66
      @first_ride_this_month.distance = new_first_ride_distance
      @first_ride_this_month.save!

      ride_month = RideMonth.find_by_month_and_year(@this_month, @this_months_year)
      ride_month.distance.should == new_first_ride_distance + @second_ride_this_month.distance
      ride_month.ride_count.should == 2
    end

    it 'should adjust ride-month data when an existing ride is deleted' do
      @first_ride_this_month.destroy
      ride_month = RideMonth.find_by_month_and_year(@this_month, @this_months_year)
      ride_month.distance.should == @second_ride_this_month.distance
      ride_month.ride_count.should == 1
    end

    it 'should adjust ride-month data when an existing ride is moved to an existing ride month' do
      @first_ride_this_month.ride_on = Time.new.advance(:months => -1) # Move this ride to last month
      @first_ride_this_month.save

      ride_month = RideMonth.find_by_month_and_year(@this_month, @this_months_year)
      ride_month.distance.should == @second_ride_this_month.distance
      ride_month.ride_count.should == 1

      ride_month = RideMonth.find_by_month_and_year(@last_month, @last_months_year)
      ride_month.distance.should == @first_ride_this_month.distance + @last_month_ride.distance
      ride_month.ride_count.should == 2

    end

    it 'should adjust ride-month data when an existing ride is moved to a non-existent ride month' do
      @first_ride_this_month.ride_on = Time.new.advance(:months => 3) # Move this ride to month not yet ridden on
      @first_ride_this_month.save
      @first_ride_this_month.reload

      ride_month = RideMonth.find_by_month_and_year(@this_month, @this_months_year)
      ride_month.distance.should == @second_ride_this_month.distance
      ride_month.ride_count.should == 1

      ride_month = RideMonth.find_by_month_and_year(@first_ride_this_month.ride_on.month, @first_ride_this_month.ride_on.year)
      ride_month.should_not be_nil
      ride_month.distance.should == @first_ride_this_month.distance
      ride_month.ride_count.should == 1
    end
    
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
