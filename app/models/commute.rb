class Commute < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :distance_to, :distance_from, :start_date
  validates_numericality_of :distance_to, :distance_from

  attr_protected :user_id
end
