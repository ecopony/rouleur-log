class Ride < ActiveRecord::Base
  belongs_to :bike
  belongs_to :route
  belongs_to :ride_type
  belongs_to :user
  
  validates_presence_of(:bike_id, :ride_on)
  validates_numericality_of(:distance)

  attr_protected :user_id
  
  def self.month_stats
    total_miles = 0
    long_ride = 0
    
    rides = Ride.find(:all,
      :conditions => ["user_id = ? AND ride_on BETWEEN ? AND ?", User.current_user.id, Time.new.at_beginning_of_month.to_date, Time.new.at_end_of_month.to_date]
    )
    
    rides.each do |ride|
      total_miles += ride.distance
      long_ride = ride.distance if ride.distance > long_ride
    end

    {:total_miles => total_miles, :ride_count => rides.size, :long_ride => long_ride }
  end
  
end