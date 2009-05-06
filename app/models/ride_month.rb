class RideMonth < ActiveRecord::Base
  belongs_to :user
  validates_presence_of(:month, :year, :distance, :ride_count, :user_id)

  attr_protected :user_id

end
