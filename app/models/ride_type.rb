class RideType < ActiveRecord::Base
  belongs_to :user

  attr_protected :user
end
