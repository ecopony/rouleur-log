class Ride < ActiveRecord::Base
  belongs_to :bike
  belongs_to :route
  belongs_to :ride_type
  belongs_to :user
  
  validates_presence_of(:bike_id, :ride_on)
  validates_numericality_of(:distance)

  before_save :update_ride_month
  after_destroy :remove_ride_from_previous_ride_month

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

    { :total_miles => total_miles, :ride_count => rides.size, :long_ride => long_ride }
  end

  protected

  def update_ride_month
    ride_month = RideMonth.find_or_initialize_by_month_and_year_and_user_id(
      self.ride_on.month,
      self.ride_on.year,
      User.current_user.id
    )

    if self.new_record? || self.new_ride_on_month_or_year?
      add_ride_to_ride_month(ride_month)
      remove_ride_from_previous_ride_month unless self.new_record?
    else
      if self.distance_changed?
        ride_month.distance += (self.distance - self.distance_was)
        ride_month.save
      end
    end
    
  end

  def new_ride_on_month_or_year?
    return true if (self.ride_on_changed? && (self.ride_on_was.month != self.ride_on.month) || (self.ride_on_was.year != self.ride_on.year))
  end

  def add_ride_to_ride_month(ride_month)
    ride_month.ride_count = ride_month.ride_count.nil? ? 1 : (ride_month.ride_count + 1)
    ride_month.distance = ride_month.distance.nil? ? self.distance : (ride_month.distance + self.distance)
    ride_month.save
  end

  def remove_ride_from_previous_ride_month
    previous_ride_month = RideMonth.find_by_month_and_year_and_user_id(
      self.ride_on_was.month,
      self.ride_on_was.year,
      User.current_user.id
    )

    previous_ride_month.ride_count = previous_ride_month.ride_count - 1
    previous_ride_month.distance = previous_ride_month.distance - self.distance_was
    previous_ride_month.save
  end
  
end