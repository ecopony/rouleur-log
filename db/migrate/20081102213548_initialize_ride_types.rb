class InitializeRideTypes < ActiveRecord::Migration
  def self.up
    User.find(:all).each do |user|
      RideType.create(:name => 'Road', :description => '', :is_commute => false, :user => user)
      RideType.create(:name => 'Commute', :description => '', :is_commute => true, :user => user)
      RideType.create(:name => 'Trainer', :description => '', :is_commute => false, :user => user)
      RideType.create(:name => 'Rollers', :description => '', :is_commute => false, :user => user)
    end
  end

  def self.down
  end
end
