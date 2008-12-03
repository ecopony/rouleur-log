class AddRideTypeToRides < ActiveRecord::Migration
  def self.up
    add_column :rides, :ride_type_id, :integer
  end

  def self.down
    remove_column :rides, :ride_type_id
  end
end
