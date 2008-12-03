class Ride < ActiveRecord::Base
  belongs_to :bike
  belongs_to :route
  belongs_to :ride_type
  
  validates_presence_of(:bike_id, :ride_on)
  validates_numericality_of(:distance)
end