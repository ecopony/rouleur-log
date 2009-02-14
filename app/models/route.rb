class Route < ActiveRecord::Base
  belongs_to :user
  validates_presence_of(:name)

  attr_protected :user
end
