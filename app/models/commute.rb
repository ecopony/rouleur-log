class Commute < ActiveRecord::Base

  validates_presence_of :name, :distance_to, :distance_from, :start_date
  validates_numericality_of :distance_to, :distance_from
end